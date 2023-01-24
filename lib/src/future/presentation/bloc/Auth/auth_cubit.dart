import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';
import 'package:journal/src/future/domain/usecases/auth/authenticate_by_credentials.dart';
import 'package:journal/src/future/domain/usecases/auth/authenticate_by_token.dart';
import 'package:journal/src/future/domain/usecases/auth/get_temporary_password.dart';
import 'package:journal/src/future/domain/usecases/auth/logout.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetTemporaryPassword getTemporaryPassword;
  final AuthenticateByCredentials authenticateByCredentials;
  final AuthenticateByToken authenticateByToken;
  final Logout performLogout;

  AuthCubit({
    required this.getTemporaryPassword,
    required this.authenticateByCredentials,
    required this.authenticateByToken,
    required this.performLogout,
  }) : super(NotAuthenticatedState());

  Future<void> tryToAuthByToken() async {
    if (state is AuthenticatingState) {
      return;
    }

    emit(AuthenticatingState());
    try {
      final AuthTokenEntity authToken =
          await authenticateByToken(AuthenticateByTokenParams());

      emit(AuthenticatedState(authToken: authToken));
    } catch (_) {
      emit(AuthenticationFailedState());
      emit(NotAuthenticatedState());
    }
  }

  Future<void> authByCredentials(String email, String password) async {
    if (state is AuthenticatingState) {
      return;
    }

    emit(AuthenticatingState());
    try {
      final AuthTokenEntity authToken = await authenticateByCredentials(
        AuthenticateByCredentialsParams(
          email: email,
          password: password,
        ),
      );

      emit(AuthenticatedState(authToken: authToken));
    } catch (_) {
      emit(AuthenticationFailedState());
      emit(NotAuthenticatedState());
    }
  }

  Future<void> logout() async {
    final currentState = state;
    if (currentState is LoggingOutState) {
      return;
    }
    if (currentState is AuthenticatedState) {
      emit(LoggingOutState(authToken: currentState.authToken));
    }

    await performLogout(LogoutParams());

    emit(NotAuthenticatedState());
  }
}
