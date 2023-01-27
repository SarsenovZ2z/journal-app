import 'package:journal/src/features/journal/domain/usecases/auth/authenticate_by_credentials.dart';
import 'package:journal/src/features/journal/domain/usecases/auth/authenticate_by_token.dart';
import 'package:journal/src/features/journal/domain/usecases/auth/logout.dart';
import 'package:journal/src/features/journal/presentation/bloc/Auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticateByCredentials authenticateByCredentials;
  final AuthenticateByToken authenticateByToken;
  final Logout performLogout;

  AuthCubit({
    required this.authenticateByCredentials,
    required this.authenticateByToken,
    required this.performLogout,
  }) : super(NotAuthenticatedState());

  Future<void> tryToAuthByToken() async {
    if (state is AuthenticatingByTokenState) {
      return;
    }

    emit(AuthenticatingByTokenState());
    final failureOrAuthToken =
        await authenticateByToken(AuthenticateByTokenParams());

    failureOrAuthToken.fold((error) {
      emit(AuthenticationFailedState(failure: error));
    }, (authToken) {
      emit(AuthenticatedState(authToken: authToken));
    });
  }

  Future<void> authByCredentials({
    required String email,
    required String password,
  }) async {
    if (state is AuthenticatingByCredentialsState) {
      return;
    }

    forgetLastError();

    emit(AuthenticatingByCredentialsState());

    final failureOrAuthToken = await authenticateByCredentials(
      AuthenticateByCredentialsParams(
        email: email,
        password: password,
      ),
    );

    failureOrAuthToken.fold((error) {
      emit(AuthenticationFailedState(failure: error));
    }, (authToken) {
      emit(AuthenticatedState(authToken: authToken));
    });
  }

  Future<void> logout() async {
    final currentState = state;

    if (currentState is LoggingOutState) {
      return;
    }

    if (currentState is AuthenticatedState) {
      emit(LoggingOutState(authToken: currentState.authToken));
    }

    final failureOrNothing = await performLogout(LogoutParams());

    failureOrNothing.fold((error) {
      // TODO: notify about failure
    }, (_) {});

    emit(NotAuthenticatedState());
  }

  void forgetLastError() {
    if (state is AuthenticationFailedState) {
      emit(NotAuthenticatedState());
    }
  }
}
