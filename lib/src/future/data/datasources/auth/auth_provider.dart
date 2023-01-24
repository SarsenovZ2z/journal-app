import 'package:journal/src/future/data/datasources/remote_data_source.dart';
import 'package:journal/src/future/data/models/auth/auth_token_model.dart';

abstract class AuthProvider<AuthParam> extends RemoteDataSource {
  AuthProvider({required super.api});

  Future<AuthTokenModel> authenticate(AuthParam params);
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
