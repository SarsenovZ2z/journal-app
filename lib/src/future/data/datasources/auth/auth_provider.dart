import 'package:journal/src/future/data/datasources/remote_data_source.dart';
import 'package:journal/src/future/data/models/auth/auth_token_model.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';

abstract class AuthProvider<AuthParam> extends RemoteDataSource {
  AuthProvider({required super.api});

  Future<AuthTokenModel> authenticate(AuthParam params);

  void setAuthToken(AuthTokenEntity? authToken) {
    api.setAuthToken(authToken);
  }
}

abstract class EmailAuthProvider extends AuthProvider<EmailAuthParams> {
  EmailAuthProvider({required super.api});

  @override
  Future<AuthTokenModel> authenticate(EmailAuthParams params);
}

class EmailAuthParams {
  final String email;
  final String password;

  EmailAuthParams({required this.email, required this.password});
}
