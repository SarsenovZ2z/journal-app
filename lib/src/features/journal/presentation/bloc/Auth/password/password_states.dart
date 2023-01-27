import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object?> get props => [];
}

class NotRequestedState extends PasswordState {}

class RequestingPasswordState extends PasswordState {}

class PasswordRequestFailedState extends PasswordState {
  final Failure failure;

  const PasswordRequestFailedState({required this.failure});

  @override
  List<Object?> get props => [
        failure,
      ];
}

class PasswordIssuedState extends PasswordState {}
