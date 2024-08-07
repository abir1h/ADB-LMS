class AuthDataModel {
  final String id;
  final String userId;
  final String userName;
  final String token;
  final String refreshToken;
  final String email;
  final String validaty;
  final String expiredTime;
  final List<String> roles;

  AuthDataModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.validaty,
    required this.expiredTime,
    required this.roles,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) => AuthDataModel(
        id: json["Id"] ?? "",
        userId: json["UserId"] ?? "",
        userName: json["UserName"] ?? "",
        token: json["Token"] ?? "",
        refreshToken: json["RefreshToken"] ?? "",
        email: json["Email"] ?? "",
        validaty: json["Validaty"] ?? "",
        expiredTime: json["ExpiredTime"] ?? "",
        roles: json["Roles"] != null
            ? List<String>.from(json["Roles"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserId": userId,
        "UserName": userName,
        "Token": token,
        "RefreshToken": refreshToken,
        "Email": email,
        "Validaty": validaty,
        "ExpiredTime": expiredTime,
        "Roles": List<dynamic>.from(roles.map((x) => x)),
      };
}
