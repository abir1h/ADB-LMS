class ServerResponse {
  final String message;
  final dynamic data;
  final List<Map<String, String>>? errors;

  ServerResponse({required this.message, this.data, this.errors});

  factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
      message: json['message'] ?? "",
      data: json['data'],
      errors: json['errors'] == null
          ? []
          : List<Map<String, String>>.from(json["errors"].map((x) => x)));
}
