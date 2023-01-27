import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/features/journal/domain/entities/auth/auth_token_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class NotAuthenticatedState extends AuthState {}

class AuthenticationFailedState extends NotAuthenticatedState {
  final Failure failure;

  AuthenticationFailedState({required this.failure});

  @override
  List<Object?> get props => [
        failure,
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
