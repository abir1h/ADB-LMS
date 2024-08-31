class AuthDataEntity {
  final String id;
  final String userId;
  final String userName;
  final String token;
  final String refreshToken;
  final String email;
  final String validaty;
  final String expiredTime;
  final List<String> roles;
  final String data;
  final int status;

  AuthDataEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.validaty,
    required this.expiredTime,
    required this.roles,
    required this.data,
    required this.status,
  });
}
