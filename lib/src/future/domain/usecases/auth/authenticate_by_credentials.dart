import 'package:dartz/dartz.dart';
import 'package:journal/src/core/failure.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';

class AuthenticateByCredentials extends UseCase<
    Either<Failure, AuthTokenEntity>, AuthenticateByCredentialsParams> {
  final AuthRepository authRepository;

  AuthenticateByCredentials({required this.authRepository});

  @override
  Future<Either<Failure, AuthTokenEntity>> call(
      AuthenticateByCredentialsParams params) async {
    return authRepository.authenticateByCredentials(
      email: params.email,
      password: params.password,
    );
  }
}

class AuthenticateByCredentialsParams {
  final String email;
  final String password;

  AuthenticateByCredentialsParams({
    required this.email,
    required this.password,
  });
}
