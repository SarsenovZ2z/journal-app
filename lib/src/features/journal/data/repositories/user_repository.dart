import 'package:journal/src/features/journal/domain/entities/user_entity.dart';
import 'package:journal/src/features/journal/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<UserEntity> getCurrentUser() async {
    return const UserEntity(
      id: 1,
      name: 'Nurdaulet',
      email: 'nurik9293709@gmail.com',
    );
  }
}
