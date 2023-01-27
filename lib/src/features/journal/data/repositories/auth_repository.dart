import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/functions.dart';
import 'package:journal/src/features/journal/data/datasources/auth/auth_provider.dart';
import 'package:journal/src/features/journal/data/datasources/auth/temporary_password_auth/temporary_password_auth_provider.dart';
import 'package:journal/src/features/journal/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/features/journal/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final String _accessTokenName = 'accessToken';
  final String _refreshTokenName = 'refreshToken';

  final FlutterSecureStorage secureStorage;
  final TemporaryPasswordAuthProvider authProvider;

  AuthRepositoryImpl({
    required this.secureStorage,
    required this.authProvider,
  });

  @override
  Future<Either<Failure, void>> getTemporaryPassword(String email) async {
    try {
      return Right(await authProvider.getTemporaryPassword(email));
    } catch (e) {
      return const Left(NetworkFailure('Oops.. Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> authenticateByCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final AuthTokenEntity authToken = await authProvider.authenticate(
        EmailAuthParams(
          email: email,
          password: password,
        ),
      );

      await _storeAuthToken(authToken);

      authProvider.setAuthToken(authToken);

      return Right(authToken);
    } catch (error) {
      return const Left(NetworkFailure('Invalid credentials'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // TODO: send logout request
    } catch (_) {}
    authProvider.setAuthToken(null);
    await _forgetAuthToken();
    return const Right(null);
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> authenticateByToken() async {
    final AuthTokenEntity? authToken = await _getAuthToken();

    if (authToken == null) {
      return const Left(LocalFailure('Auth token not found'));
    }

    if (!await _checkAuthToken(authToken)) {
      await _forgetAuthToken();
      return const Left(LocalFailure('Invalid auth token'));
    }

    authProvider.setAuthToken(authToken);

    return Right(authToken);
  }

  Future<bool> _checkAuthToken(AuthTokenEntity authToken) async {
    await slowAwait();
    return true;
  }

  Future<AuthTokenEntity?> _getAuthToken() async {
    late final String? accessToken;
    late final String? refreshToken;

    await Future.wait([
      secureStorage.read(key: _accessTokenName).then((value) {
        accessToken = value;
      }),
      secureStorage
          .read(key: _refreshTokenName)
          .then((value) => refreshToken = value),
    ]);

    if (accessToken == null) {
      return null;
    }

    return AuthTokenEntity(
      accessToken: accessToken!,
      refreshToken: refreshToken,
    );
  }

  Future<void> _storeAuthToken(AuthTokenEntity authToken) async {
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
