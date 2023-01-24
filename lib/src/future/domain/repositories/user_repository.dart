import 'package:journal/src/future/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getCurrentUser();
}
