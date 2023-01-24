import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:journal/src/core/services/api.dart';
import 'package:journal/src/future/data/datasources/auth/auth_provider.dart';
import 'package:journal/src/future/data/datasources/auth/temporary_password_auth/temporary_password_auth_provider.dart';
import 'package:journal/src/future/data/datasources/remote_data_source.dart';
import 'package:journal/src/future/data/datasources/user_remote_data_source.dart';
import 'package:journal/src/future/data/repositories/auth_repository.dart';
import 'package:journal/src/future/data/repositories/user_repository.dart';
import 'package:journal/src/future/domain/repositories/auth_repository.dart';
import 'package:journal/src/future/domain/repositories/user_repository.dart';
import 'package:journal/src/future/domain/usecases/auth/authenticate_by_credentials.dart';
import 'package:journal/src/future/domain/usecases/auth/authenticate_by_token.dart';
import 'package:journal/src/future/domain/usecases/auth/get_temporary_password.dart';
import 'package:journal/src/future/domain/usecases/auth/logout.dart';
import 'package:journal/src/future/domain/usecases/get_current_user.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<Api>(() => Api(authCubit: sl()));

  // BLoC / Cubit
  // It is important to register "AuthCubit" as "Singleton"
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(
        getTemporaryPassword: sl(),
        authenticateByCredentials: sl(),
        authenticateByToken: sl(),
        performLogout: sl(),
      ));

  // UseCases
  sl.registerLazySingleton<GetTemporaryPassword>(() => GetTemporaryPassword(
        authRepository: sl(),
      ));

  sl.registerLazySingleton<AuthenticateByCredentials>(
      () => AuthenticateByCredentials(
            authRepository: sl(),
          ));

  sl.registerLazySingleton<AuthenticateByToken>(() => AuthenticateByToken(
        authRepository: sl(),
      ));

  sl.registerLazySingleton<Logout>(() => Logout(
        authRepository: sl(),
      ));

  sl.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser(
        userRepository: sl(),
      ));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        secureStorage: sl(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  // DataSources
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
        api: sl(),
      ));

  sl.registerLazySingleton<AuthProvider>(() => sl<EmailAuthProvider>());

  sl.registerLazySingleton<EmailAuthProvider>(
      () => sl<TemporaryPasswordAuthProviderImpl>());

  sl.registerLazySingleton<TemporaryPasswordAuthProviderImpl>(
      () => TemporaryPasswordAuthProviderImpl(
            api: sl(),
          ));

  // External
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}
