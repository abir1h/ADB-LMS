class ResponseEntity<T> {
  final String? message;
  final String? error;
  final int? status;
  final T? data;

  ResponseEntity(
      {required this.message, required this.error, required this.status, required this.data});
}
