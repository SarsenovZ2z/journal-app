import 'package:equatable/equatable.dart';
import 'package:journal/src/future/domain/entities/auth/auth_token_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class NotAuthenticatedState extends AuthState {}

class AuthenticatingState extends NotAuthenticatedState {}

class AuthenticationFailedState extends NotAuthenticatedState {}

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
