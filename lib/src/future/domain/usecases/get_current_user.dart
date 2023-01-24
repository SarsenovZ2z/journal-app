import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/future/domain/entities/user_entity.dart';
import 'package:journal/src/future/domain/repositories/user_repository.dart';

class GetCurrentUser extends UseCase<UserEntity, GetCurrentUserParams> {
  final UserRepository userRepository;

  GetCurrentUser({
    required this.userRepository,
  });

  @override
  Future<UserEntity> call(GetCurrentUserParams params) async {
    return userRepository.getCurrentUser();
  }
}

class GetCurrentUserParams {}
