import 'package:journal/src/future/data/datasources/auth/auth_provider.dart';
import 'package:journal/src/future/data/models/auth/auth_token_model.dart';

abstract class TemporaryPasswordAuthProvider extends EmailAuthProvider {
  TemporaryPasswordAuthProvider({required super.api});

  Future<void> getTemporaryPassword(String email);

  @override
  Future<AuthTokenModel> authenticate(EmailAuthParams params);
}

class TemporaryPasswordAuthProviderImpl extends TemporaryPasswordAuthProvider {
  TemporaryPasswordAuthProviderImpl({required super.api});

  @override
  Future<AuthTokenModel> authenticate(EmailAuthParams params) async {
    final response = await api.httpClient.post('/v1/auth/signin', data: {
      'email': params.email,
      'password': params.password,
    });
    return AuthTokenModel.fromJson(response.data);
  }

  @override
  Future<void> getTemporaryPassword(String email) async {
    await api.httpClient.get('/v1/auth/signin', queryParameters: {
      'email': email,
    });
  }

  @override
  Future<void> logout() async {}
}
