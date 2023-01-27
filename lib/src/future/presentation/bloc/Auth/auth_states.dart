import 'package:equatable/equatable.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class NotAuthenticatedState extends AuthState {}

class AuthenticationFailedState extends NotAuthenticatedState {
  final String errorMessage;

  AuthenticationFailedState({required this.errorMessage});

  @override
  List<Object?> get props => [
        errorMessage,
      ];
}

class RequestingNewPasswordState extends NotAuthenticatedState {}

class PasswordResetFailedState extends NotAuthenticatedState {}

class NewPasswordIssuedState extends NotAuthenticatedState {
  final String email;

  NewPasswordIssuedState({required this.email});

  @override
  List<Object?> get props => [
        email,
      ];
}

class AuthenticatingState extends NotAuthenticatedState {}

class AuthenticatingByTokenState extends AuthenticatingState {}

class AuthenticatingByCredentialsState extends AuthenticatingState {}

class AuthenticatedState extends AuthState {
  final AuthTokenEntity authToken;

  const AuthenticatedState({required this.authToken});

  @override
  List<Object?> get props => [
        authToken,
      ];
}

class LoggingOutState extends AuthenticatedState {
  const LoggingOutState({required super.authToken});
}
