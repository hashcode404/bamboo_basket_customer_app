import '../../infrastructure/core/failures/app_exceptions.dart';
import 'api_response.dart';

mixin BaseController {
  Future<void> init() async {}

  void dispose() {}

  APIResponse<T> throwNotFoundException<T>() {
    return APIResponse.error(
      "The requested api data was not found.",
      exception: NotFoundException(),
    );
  }

  APIResponse<T> throwInvalidResponseFromServer<T>() {
    return APIResponse.error(
      "Invalid response from the server.",
      exception: InternalServerErrorException(),
    );
  }

  APIResponse<T> throwUnknownErrorException<T>() {
    final error = GenericAppException(
      prefix: "Unknown Error",
      message: "Unknown error response",
    );
    return APIResponse.error(
      error.prefix,
      exception: error,
    );
  }

  APIResponse<T> throwAppException<T>(AppExceptions error) {
    return APIResponse.error(
      error.message,
      exception: error,
    );
  }
}
