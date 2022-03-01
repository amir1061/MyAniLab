class MalException implements Exception {
  final String message;
  final String prefix;

  MalException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends MalException {
  FetchDataException(String message)
      : super(message: message, prefix: "Internal server error: ");
}

class BadRequestException extends MalException {
  BadRequestException(message)
      : super(message: message, prefix: "Invalid Request: ");
}

class UnauthorisedException extends MalException {
  UnauthorisedException(message)
      : super(message: message, prefix: "Unauthorised: ");
}

class ForbidenException extends MalException {
  ForbidenException(message) : super(message: message, prefix: "Forbiden: ");
}

class NotFoundException extends MalException {
  NotFoundException(message) : super(message: message, prefix: "Forbiden: ");
}

class InvalidInputException extends MalException {
  InvalidInputException(String message)
      : super(message: message, prefix: "Invalid Input: ");
}

class MalFormatException extends MalException {
  MalFormatException(String message)
      : super(message: message, prefix: "Format Exception: ");
}

class NoNetworkException extends MalException {
  NoNetworkException(String message)
      : super(message: message, prefix: "No Network: ");
}

class UnknownExcption extends MalException {
  UnknownExcption(String message)
      : super(message: message, prefix: "Uknown Error: ");
}
