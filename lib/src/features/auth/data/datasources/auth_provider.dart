import 'package:journal/src/features/auth/data/models/auth_token_model.dart';
import 'package:journal/src/features/auth/domain/entities/auth_token_entity.dart';

abstract class AuthProvider<AuthParam> {
  Future<AuthTokenModel> authenticate(AuthParam params);

  Future<bool> checkAuthToken(AuthTokenEntity authToken);

  Future<void> logout();

  void setAuthToken(AuthTokenEntity? authToken);
}

abstract class EmailAuthProvider extends AuthProvider<EmailAuthParams> {
  @override
  Future<AuthTokenModel> authenticate(EmailAuthParams params);
}

class EmailAuthParams {
  final String email;
  final String password;

  EmailAuthParams({required this.email, required this.password});
}
