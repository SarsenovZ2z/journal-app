import 'package:journal/src/features/profile/domain/entities/user_entity.dart';
import 'package:journal/src/features/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<UserEntity> getCurrentUser() async {
    return const UserEntity(
      name: 'Nurdaulet',
      email: 'nurik9293709@gmail.com',
    );
  }
}
