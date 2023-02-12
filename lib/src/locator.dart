import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:journal/src/features/books/domain/usecases/get_book.dart';
import 'package:journal/src/routes.dart' as router;
import 'package:journal/src/core/services/api.dart';
import 'package:journal/src/core/services/url_resolver.dart';
import 'package:journal/src/features/auth/data/datasources/auth_provider.dart';
import 'package:journal/src/features/auth/data/datasources/temporary_password_auth_provider.dart';
import 'package:journal/src/features/books/data/datasources/book_data_source.dart';
import 'package:journal/src/features/books/data/repositories/book_respository.dart';
import 'package:journal/src/features/books/domain/repositories/book_repository.dart';
import 'package:journal/src/features/books/domain/usecases/get_current_user_books.dart';
import 'package:journal/src/features/books/presentation/bloc/book_cubit.dart';
import 'package:journal/src/features/books/presentation/bloc/user_books_cubit.dart';
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
import 'package:journal/src/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:journal/src/features/auth/presentation/bloc/password/password_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<Api>(() => Api());
  sl.registerSingletonAsync<UrlResolver>(() => router.init());

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

  sl.registerFactory<UserBooksCubit>(
    () => UserBooksCubit(
      getCurrentUserBooks: sl(),
    ),
  );

  sl.registerFactory<BookCubit>(
    () => BookCubit(getBook: sl()),
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

  sl.registerLazySingleton<GetCurrentUserBooks>(
    () => GetCurrentUserBooks(
      bookRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GetBook>(
    () => GetBook(
      bookRepository: sl(),
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

  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      bookDataSource: sl(),
    ),
  );

  // DataSources
  sl.registerLazySingleton<UserDataSource>(
    () => UserRemoteDataSource(
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
    () => RemoteTemporaryPasswordAuthProvider(
      api: sl(),
    ),
  );

  sl.registerLazySingleton<BookDataSource>(
    () => BookRemoteDataSource(
      api: sl(),
    ),
  );

  // External
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
}
