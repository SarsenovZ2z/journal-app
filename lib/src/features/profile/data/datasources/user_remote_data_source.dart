import 'package:journal/src/core/remote_data_source.dart';
import 'package:journal/src/features/profile/data/models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel?> getCurrentUser();
}

class UserRemoteDataSource extends RemoteDataSource implements UserDataSource {
  UserRemoteDataSource({required super.api});

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }
}
