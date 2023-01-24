import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';

class AuthenticateByToken
    extends UseCase<AuthTokenEntity, AuthenticateByTokenParams> {
  final AuthRepository authRepository;

  AuthenticateByToken({
    required this.authRepository,
  });

  @override
  Future<AuthTokenEntity> call(AuthenticateByTokenParams params) async {
    return authRepository.authenticateByToken();
  }
}

class AuthenticateByTokenParams {}
