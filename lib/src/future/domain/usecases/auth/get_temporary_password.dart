import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';

class GetTemporaryPassword extends UseCase<void, GetTemporaryPasswordParams> {
  final AuthRepository authRepository;

  GetTemporaryPassword({
    required this.authRepository,
  });

  @override
  Future<void> call(GetTemporaryPasswordParams params) async {
    return authRepository.getTemporaryPassword(params.email);
  }
}

class GetTemporaryPasswordParams {
  final String email;

  GetTemporaryPasswordParams({required this.email});
}
