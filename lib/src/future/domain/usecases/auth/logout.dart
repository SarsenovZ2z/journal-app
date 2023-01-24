import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';

class Logout extends UseCase<void, LogoutParams> {
  final AuthRepository authRepository;

  Logout({
    required this.authRepository,
  });

  @override
  Future<void> call(LogoutParams params) async {
    return authRepository.logout();
  }
}

class LogoutParams {}
