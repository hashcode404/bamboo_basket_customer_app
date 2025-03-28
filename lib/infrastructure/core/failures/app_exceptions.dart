abstract class AppExceptions implements Exception {
  final String message;
  final String prefix;

  static const String defaultErrorMessage = 'Something went wrong';

  AppExceptions({
    this.message = defaultErrorMessage,
    required this.prefix,
  });
}

class UnauthorizedAccessException implements AppExceptions {
  @override
  final String prefix = 'Unauthorized access';
  @override
  final String message = 'Unauthorized access. Please log in to continue.';
}

class NotFoundException implements AppExceptions {
  @override
  final String prefix = 'Not Found';
  @override
  final String message = 'The requested resource was not found.';
}

class ConnectionLostException implements AppExceptions {
  @override
  final String prefix = 'Connection Lost';
  @override
  final String message = 'Connection to the server was lost.';
}

class ConnectionSlowException implements AppExceptions {
  @override
  final String prefix = 'Connection Slow';
  @override
  final String message = 'The connection is slow. Please try again later.';
}

class UserCancelException implements AppExceptions {
  @override
  final String prefix = 'User Cancelled';
  @override
  final String message = 'The user cancelled the operation.';
}

class TimeoutException implements AppExceptions {
  @override
  final String prefix = 'Timeout';
  @override
  final String message = 'The operation timed out.';
}

class InternalServerErrorException implements AppExceptions {
  @override
  String prefix = 'Internal Server Error';
  @override
  String message = 'An internal server error occurred.';

  // Constructor to override prefix and message values
  InternalServerErrorException({String? prefix, String? message}) {
    if (prefix != null) {
      this.prefix = prefix;
    }
    if (message != null) {
      this.message = message;
    }
  }
}

class BadRequestErrorException implements AppExceptions {
  @override
  final String prefix;
  @override
  final String message;

  BadRequestErrorException({
    this.prefix = "Invalid request payload",
    this.message = "Invalid request data. Please check data and try again.",
  });
}

class ReponseSyntaxException implements AppExceptions {
  @override
  final String prefix = 'Invalid format Error';
  @override
  final String message =
      'Invalid Response Syntax. Please check the syntax and try again';
}

class FormatErrorException implements AppExceptions {
  @override
  final String prefix = 'Invalid format Error';
  @override
  final String message =
      'Invalid JSON format. Please check the syntax and try again';
}

class GenericAppException implements AppExceptions {
  @override
  final String prefix;
  @override
  final String message;

  GenericAppException({
    required this.prefix,
    required this.message,
  });
}
