import 'package:dartz/dartz.dart';
import 'package:journal/src/core/failure.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';

class Logout extends UseCase<Either<Failure, void>, LogoutParams> {
  final AuthRepository authRepository;

  Logout({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(LogoutParams params) async {
    return authRepository.logout();
  }
}

class LogoutParams {}
