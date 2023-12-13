class Response {
  final String message;
  final int statusCode;
  final dynamic data;

  const Response({required this.message, required this.statusCode, required this.data});

  static Response fromMap(dynamic map) => Response(
    message: map['message'],
    statusCode: map['statusCode'],
    data: map['data'],
  );
}