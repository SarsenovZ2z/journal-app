import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:journal/src/core/services/api.dart';
import 'package:journal/src/features/auth/data/datasources/auth_provider.dart';
import 'package:journal/src/features/auth/data/datasources/temporary_password_auth_provider.dart';
import 'package:journal/src/features/profile/data/datasources/user_remote_data_source.dart';
import 'package:journal/src/features/auth/data/repositories/auth_repository.dart';
import 'package:journal/src/features/profile/data/repositories/user_repository.dart';
import 'package:journal/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:journal/src/features/profile/domain/repositories/user_repository.dart';
import 'package:journal/src/features/auth/domain/usecases/authenticate_by_credentials.dart';
import 'package:journal/src/features/auth/domain/usecases/authenticate_by_token.dart';
import 'package:journal/src/features/auth/domain/usecases/get_temporary_password.dart';
import 'package:journal/src/features/auth/domain/usecases/logout.dart';
import 'package:journal/src/features/profile/domain/usecases/get_current_user.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/auth_cubit.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/password/password_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<Api>(() => Api());

  // BLoC / Cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      authenticateByCredentials: sl(),
      authenticateByToken: sl(),
      performLogout: sl(),
    ),
  );
  sl.registerFactory<PasswordCubit>(
    () => PasswordCubit(
      getTemporaryPassword: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton<GetTemporaryPassword>(
    () => GetTemporaryPassword(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AuthenticateByCredentials>(
    () => AuthenticateByCredentials(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AuthenticateByToken>(
    () => AuthenticateByToken(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<Logout>(
    () => Logout(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(
      userRepository: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      secureStorage: sl(),
      authProvider: sl(),
    ),
  );

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());

  // DataSources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      api: sl(),
    ),
  );

  sl.registerFactory<AuthProvider>(
    () => sl<EmailAuthProvider>(),
  );

  sl.registerFactory<EmailAuthProvider>(
    () => sl<TemporaryPasswordAuthProvider>(),
  );

  sl.registerFactory<TemporaryPasswordAuthProvider>(
    () => TemporaryPasswordAuthProviderImpl(
      api: sl(),
    ),
  );

  // External
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}
