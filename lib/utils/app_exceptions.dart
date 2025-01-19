/// The above code defines a set of exception classes for handling different types of errors in a Dart
/// application.



abstract class AppException implements Exception {
  final String message;
  final String prefix;

  AppException([this.message = "", this.prefix = ""]);
}



class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message ?? "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message ?? "Invalid Request: ");
}


class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message ?? "Unauthorised: ");
}



class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message ?? "Invalid Input: ");
}

class NoInternetException extends AppException {
  NoInternetException([String? message]) : super(message ?? "No Internet: ");
}


class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message]) : super(message ?? "Internal Server Error: ");
}