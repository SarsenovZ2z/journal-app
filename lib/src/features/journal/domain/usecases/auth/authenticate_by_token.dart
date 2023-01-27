import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/features/journal/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/features/journal/domain/repositories/auth_repository.dart';

class AuthenticateByToken extends UseCase<Either<Failure, AuthTokenEntity>,
    AuthenticateByTokenParams> {
  final AuthRepository authRepository;

  AuthenticateByToken({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, AuthTokenEntity>> call(
      AuthenticateByTokenParams params) async {
    return authRepository.authenticateByToken();
  }
}

class AuthenticateByTokenParams {}
