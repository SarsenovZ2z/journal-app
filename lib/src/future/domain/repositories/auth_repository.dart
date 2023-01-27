import 'package:dartz/dartz.dart';
import 'package:journal/src/core/failure.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> getTemporaryPassword(String email);

  Future<Either<Failure, AuthTokenEntity>> authenticateByCredentials({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthTokenEntity>> authenticateByToken();

  Future<Either<Failure, void>> logout();
}
