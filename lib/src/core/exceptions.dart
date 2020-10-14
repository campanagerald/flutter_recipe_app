class EmailExistException implements Exception {
  String message;

  EmailExistException([String message = "Email already exists"]) {
    this.message = message;
  }

  @override
  String toString() => message;
}

class DocumentNotFoundException implements Exception {
  String message;

  DocumentNotFoundException([String message = "Document not found"]) {
    this.message = message;
  }

  @override
  String toString() => message;
}

class AuthenticationException implements Exception {
  String message;

  AuthenticationException(message) {
    this.message = message;
  }

  @override
  String toString() => message;
}
