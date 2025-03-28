import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aj_customer/core/constants/app_identifiers.dart';
import 'package:aj_customer/infrastructure/user/user_shared_prefs_repo.dart';

import '../end_points/end_points.dart';
import '../failures/app_exceptions.dart';

class APIManager {
  static const int _timeLimit = 120;

  static ResponseType get responseType => ResponseType.json;

  static String get contentType => "application/json";

  static BaseOptions get _baseOptions => BaseOptions(
        connectTimeout: const Duration(seconds: _timeLimit),
        receiveTimeout: const Duration(seconds: _timeLimit),
        baseUrl: Endpoints.baseUrl,
        contentType: contentType,
        responseType: responseType,
      );

  static Dio get dio => Dio(_baseOptions)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: requestInterceptorHandler,
        onResponse: responseInterceptorHandler,
        onError: errorResponseHandler,
      ),
    );

  // ..interceptors.add(LogInterceptor(
  //   error: true,
  //   request: true,
  //   requestHeader: true,
  //   requestBody: true,
  //   responseBody: true,
  // ));

  static void requestInterceptorHandler(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final needAuth = (options.headers["needToken"] as bool);
    if (!needAuth) return handler.next(options);
    final auth = await UserSharedPrefsRepo().getUserData();
    log(auth?.token.toString() ?? '', name: "TOKEN");
    if (auth == null || auth.token.isEmpty) {
      final error = UnauthorizedAccessException();
      return handler.reject(
        DioException(
          requestOptions: options,
          message: error.message,
          type: DioExceptionType.unknown,
          error: error,
        ),
      );
    }

    final authDataKey = (options.headers["authDataKey"] as String?) ?? "x-user";

    options.headers.remove("needToken");
    options.headers.remove("authDataKey");
    options.headers.addAll({authDataKey: auth.token});
    handler.next(options);
  }

  static void responseInterceptorHandler(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final data = response.data;
    if (data == null) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          message: InternalServerErrorException().message,
          type: DioExceptionType.badResponse,
          error: InternalServerErrorException(),
        ),
      );
    }

    try {
      final jsonData = jsonDecode(data) as Map<String, dynamic>?;
      if (jsonData?["error"] ?? false) {
        final errorMessage = _getErrorMessage(jsonData);
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            message: errorMessage,
            type: DioExceptionType.badResponse,
            error: _mapDioExceptionTypeToAppException(
              DioExceptionType.badResponse,
              errorMessage,
            ),
          ),
        );
      }

      final dataKey = response.requestOptions.headers["dataKey"] ?? "data";
      final checking = response.requestOptions.headers["dataKeyChecking"] ?? true;
      if (!checking) return handler.next(response);

      final responseData = jsonData?[dataKey];
      if (responseData == null) {
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            message: ReponseSyntaxException().message,
            type: DioExceptionType.badResponse,
            error: ReponseSyntaxException(),
          ),
        );
      }

      response.data = jsonEncode(responseData);
      handler.next(response);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          message: FormatErrorException().message,
          type: DioExceptionType.badResponse,
          error: FormatErrorException(),
        ),
      );
    }
  }

  static String _getErrorMessage(Map<String, dynamic>? jsonData) {
    return jsonData?["message"] ??
        jsonData?["errorMessage"]?["message"] ??
        jsonData?["errorMessage"]?["message"]?.first ??
        jsonData?["message"]?.first ??
        jsonData?["messages"]?.first ??
        jsonData?["data"]?["message"] ??
        jsonData?["data"]?["message"]?.first ??
        jsonData?["data"]?["messages"]?.first ??
        "Something went wrong!";
  }

  static void errorResponseHandler(
    DioException dioError,
    ErrorInterceptorHandler handler,
  ) async {
    final res = dioError.response;

    if (res == null) return;

    final status = res.statusCode;
    final (message, reason) = parseResponse(res.data);

    if (status == 401 && message == "Expired token") {
      final repo = UserSharedPrefsRepo();
      final auth = await repo.getUserData();
      if (auth == null) return;

      final response = await post(
        api: Endpoints.kUserLoginSecret,
        data: {"user": auth.user.userID, "FPsecretkey": AppIdentifiers.kSecretKey},
      );

      if (response == null) {
        return handler.reject(DioException(
          requestOptions: dioError.requestOptions,
          error: UnauthorizedAccessException(),
          type: dioError.type,
          message: "Unauthorized access",
        ));
      }

      final accessToken = jsonDecode(response)["token"];
      await repo.saveUserData(auth.copyWith(token: accessToken));

      try {
        final newRequestOptions = dioError.requestOptions..headers["x-user"] = accessToken;
        final dio = Dio();
        final retryResponse = await dio.fetch(newRequestOptions);
        handler.resolve(retryResponse);
        return;
      } catch (retryError) {
        handler.reject(retryError as DioException);
        return;
      }
    }

    final response = reason != null ? Response(requestOptions: dioError.requestOptions, data: reason) : res;

    final exception = _mapDioExceptionTypeToAppException(dioError.type, message);
    handler.reject(DioException(
      requestOptions: dioError.requestOptions,
      error: exception,
      type: dioError.type,
      response: response,
      message: exception.message,
    ));
  }

  static AppExceptions _mapDioExceptionTypeToAppException(DioExceptionType type, String? message) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return ConnectionSlowException();
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        return InternalServerErrorException(message: message);
      case DioExceptionType.cancel:
        return UserCancelException();
      case DioExceptionType.connectionError:
        return ConnectionLostException();
      default:
        return InternalServerErrorException(message: message);
    }
  }

  static (String?, dynamic) parseResponse(String data) {
    try {
      final jsonData = json.decode(data) as Map<String, dynamic>?;

      String? message;
      dynamic reason;

      if (jsonData != null) {
        message = jsonData['message'] ??
            jsonData['errorMessage']?['message'] ??
            jsonData['errorMessage']?['message']?.first ??
            jsonData['message']?.first ??
            jsonData['messages']?.first ??
            jsonData['data']?['message'] ??
            jsonData['data']?['message']?.first ??
            jsonData['data']?['messages']?.first;

        reason = jsonData['errorMessage']?['reason'];

        if (message is List) {
          message = (message as List).join(', ');
        }
      }

      return (message, reason);
    } catch (_) {
      debugPrint('Not JSON Decodable: $data');
    }
    return (null, null);
  }

  //GET
  static Future<String?> get({
    bool needAuth = false,
    String? baseUrl,
    required String api,
    String params = '',
    String? dataKey,
    bool dataKeyChecking = true,
    Map<String, String>? additionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = baseUrl != null ? baseUrl + api + params : api + params;
    var headers = {
      'needToken': needAuth,
      'content-type': contentType,
      'dataKey': dataKey,
      'dataKeyChecking': dataKeyChecking,
    };
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final response = await dio.get<String>(
      url,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  //POST
  static Future<String?> post({
    bool needAuth = false,
    String? baseUrl,
    String? dataKey,
    bool dataKeyChecking = true,
    String? authDataKey,
    required String api,
    Object? data,
    String params = '',
    Map<String, dynamic>? additionalHeaders,
    Map<String, dynamic>? queryParameters,
    String contentType = Headers.jsonContentType,
  }) async {
    final url = baseUrl != null ? baseUrl + api + params : api + params;
    var headers = {
      'needToken': needAuth,
      'content-type': contentType,
      'dataKey': dataKey,
      'dataKeyChecking': dataKeyChecking,
      'authDataKey': authDataKey,
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final response = await dio.post<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  //PUT
  static Future<String?> put({
    bool needAuthentication = false,
    String? baseUrl,
    required String api,
    String params = '',
    Object? data,
    String? dataKey,
    bool dataKeyChecking = true,
    Map<String, dynamic>? additionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) async {
    var headers = {
      'needToken': needAuthentication,
      'content-type': contentType,
      'dataKey': dataKey,
      'dataKeyChecking': dataKeyChecking,
    };

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final response = await dio.put<String>(api + params,
        data: data, queryParameters: queryParameters, options: Options(headers: headers));
    return response.data;
  }

  //PUT
  static Future<String?> patch({
    bool needAuthentication = false,
    String? baseUrl,
    required String api,
    String params = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.patch<String>(api + params,
        data: data, queryParameters: queryParameters, options: Options(headers: {'needToken': needAuthentication}));
    return response.data;
  }

  //DELETE
  static Future<String?> delete({
    bool needAuthentication = false,
    String? baseUrl,
    required String api,
    String params = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = baseUrl != null ? baseUrl + api + params : api + params;
    final response = await dio.delete<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: {'needToken': needAuthentication}),
    );

    return response.data;
  }
}
