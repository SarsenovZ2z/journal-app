import 'package:journal/src/features/journal/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getCurrentUser();
}
