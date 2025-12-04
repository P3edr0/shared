import '../../domain/entities/login_response_entity.dart';

class LoginResponseMapper {
  static LoginResponseEntity fromJson(Map<String, dynamic> data) {
    return LoginResponseEntity(
      email: data['email'],
      tokenId: data['tokenId'],
      expiresIn: int.parse(data['expiresIn']),
      refreshToken: data['refreshToken'],
      registered: data['registered'],
    );
  }
}
