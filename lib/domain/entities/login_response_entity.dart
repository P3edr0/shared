class LoginResponseEntity {
  LoginResponseEntity({
    required this.email,
    required this.tokenId,
    required this.refreshToken,
    required this.registered,
    required this.expiresIn,
  });
  final String email;
  final String tokenId;
  final String? refreshToken;
  final bool registered;
  final int expiresIn;
}
