import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';

abstract class AuthRepository {
  Future<void> getTemporaryPassword(String email);

  Future<AuthTokenEntity> authenticateByCredentials({
    required String email,
    required String password,
  });

  Future<AuthTokenEntity> authenticateByToken();

  Future<void> logout();
}
