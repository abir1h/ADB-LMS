class ResponseEntity<T> {
  final String? message;
  final String? error;
  final T? data;

  ResponseEntity(
      {required this.message, required this.error, required this.data});
}
