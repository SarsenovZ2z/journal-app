import 'package:journal/src/core/remote_data_source.dart';
import 'package:journal/src/features/auth/data/models/auth_token_model.dart';
import 'package:journal/src/features/auth/domain/entities/auth_token_entity.dart';

abstract class AuthProvider<AuthParam> extends RemoteDataSource {
  AuthProvider({required super.api});

  Future<AuthTokenModel> authenticate(AuthParam params);

  Future<bool> checkAuthToken(AuthTokenEntity authToken);

  Future<void> logout();

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
