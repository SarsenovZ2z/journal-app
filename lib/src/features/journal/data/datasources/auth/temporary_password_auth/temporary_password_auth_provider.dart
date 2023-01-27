import 'package:journal/src/features/journal/data/datasources/auth/auth_provider.dart';
import 'package:journal/src/features/journal/data/models/auth/auth_token_model.dart';

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
    try {
      final response = await api.httpClient.post('/v1/auth/signin', data: {
        'email': params.email,
        'password': params.password,
      });
      return AuthTokenModel.fromJson(response.data);
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }

  @override
  Future<void> getTemporaryPassword(String email) async {
    try {
      await api.httpClient.get('/v1/auth/signin', queryParameters: {
        'email': email,
      });
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }

  @override
  Future<void> logout() async {}
}
