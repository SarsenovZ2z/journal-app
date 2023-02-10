import 'package:journal/src/core/remote_data_source.dart';
import 'package:journal/src/core/services/api.dart';
import 'package:journal/src/features/auth/data/datasources/auth_provider.dart';
import 'package:journal/src/features/auth/data/models/auth_token_model.dart';
import 'package:journal/src/features/auth/domain/entities/auth_token_entity.dart';

abstract class TemporaryPasswordAuthProvider implements EmailAuthProvider {
  Future<void> getTemporaryPassword(String email);

  @override
  Future<AuthTokenModel> authenticate(EmailAuthParams params);
}

class RemoteTemporaryPasswordAuthProvider extends RemoteDataSource
    implements TemporaryPasswordAuthProvider {
  RemoteTemporaryPasswordAuthProvider({required super.api});

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
  Future<void> logout() async {
    // @TODO: send logout request
  }

  @override
  Future<bool> checkAuthToken(AuthTokenEntity authToken) async {
    try {
      await Api.usingAuthToken(authToken).httpClient.get('/v1/auth/check');
      return true;
    } catch (error) {
      throw Exception('Something went wrong');
    }
  }

  @override
  void setAuthToken(AuthTokenEntity? authToken) {
    api.setAuthToken(authToken);
  }
}
