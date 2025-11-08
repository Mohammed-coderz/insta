class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  final bool? showMessageToUser;
  final bool? status;

  ServerException({
    this.statusCode,
    this.message,
    this.status,
    this.showMessageToUser,
  });
}
