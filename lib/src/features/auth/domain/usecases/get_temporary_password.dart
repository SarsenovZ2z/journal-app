import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/features/auth/domain/repositories/auth_repository.dart';

class GetTemporaryPassword
    extends UseCase<Either<Failure, void>, GetTemporaryPasswordParams> {
  final AuthRepository authRepository;

  GetTemporaryPassword({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, void>> call(GetTemporaryPasswordParams params) async {
    return authRepository.getTemporaryPassword(params.email);
  }
}

class GetTemporaryPasswordParams {
  final String email;

  GetTemporaryPasswordParams({required this.email});
}
