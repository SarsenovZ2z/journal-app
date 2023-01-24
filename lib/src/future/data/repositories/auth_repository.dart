import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final String _accessTokenName = 'accessToken';
  final String _refreshTokenName = 'refreshToken';

  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl({required this.secureStorage});

  @override
  Future<void> getTemporaryPassword(String email) async {
    // TODO: send request
  }

  @override
  Future<AuthTokenEntity> authenticateByCredentials({
    required String email,
    required String password,
  }) async {
    const accessToken = AuthTokenEntity(accessToken: 'accessToken');
    _setAuthToken(accessToken);
    return accessToken;
  }

  @override
  Future<void> logout() async {
    try {
      // TODO: send logout request
    } catch (_) {}
    await _forgetAuthToken();
  }

  @override
  Future<AuthTokenEntity> authenticateByToken() async {
    final AuthTokenEntity? authToken = await _getAuthToken();

    if (authToken == null) {
      throw Exception('no auth token found');
    }

    if (!await _checkAuthToken(authToken)) {
      await _forgetAuthToken();
      throw Exception('Invalid auth token');
    }

    return authToken;
  }

  Future<bool> _checkAuthToken(AuthTokenEntity authToken) async {
    await Future.delayed(const Duration(seconds: 2));
    // TODO: use Api().usingAuthToken() method
    return true;
  }

  Future<AuthTokenEntity?> _getAuthToken() async {
    late final String accessToken;
    late final String? refreshToken;

    await Future.wait([
      secureStorage.read(key: _accessTokenName).then((value) {
        if (value is String) {
          accessToken = value;
        }
      }),
      secureStorage
          .read(key: _refreshTokenName)
          .then((value) => refreshToken = value),
    ]);

    if (accessToken.isEmpty) {
      return null;
    }

    return AuthTokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> _setAuthToken(AuthTokenEntity authToken) async {
    await Future.wait([
      secureStorage.write(
        key: _accessTokenName,
        value: authToken.accessToken,
      ),
      if (authToken.refreshToken is String)
        secureStorage.write(
          key: _refreshTokenName,
          value: authToken.refreshToken,
        ),
    ]);
  }

  Future<void> _forgetAuthToken() async {
    return secureStorage.deleteAll();
  }
}
