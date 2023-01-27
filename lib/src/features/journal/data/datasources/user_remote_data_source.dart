import 'package:journal/src/features/journal/data/datasources/remote_data_source.dart';
import 'package:journal/src/features/journal/data/models/user_model.dart';

abstract class UserRemoteDataSource extends RemoteDataSource {
  UserRemoteDataSource({required super.api});
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  UserRemoteDataSourceImpl({required super.api});

  Future<UserModel?> getCurrentUser() async {
    return null;
  }
}
