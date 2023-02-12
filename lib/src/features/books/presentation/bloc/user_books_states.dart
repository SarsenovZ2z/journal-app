import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';

import 'package:journal/src/features/books/domain/entities/book_entity.dart';

abstract class UserBooksState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserBooksNotLoadedState extends UserBooksState {}

class UserBooksLoadingState extends UserBooksNotLoadedState {
  final UserBooksState oldState;

  UserBooksLoadingState({required this.oldState});

  @override
  List<Object?> get props => [
        oldState,
      ];
}

class UserBooksLoadFailedState extends UserBooksNotLoadedState {
  final Failure failure;

  UserBooksLoadFailedState({required this.failure});

  @override
  List<Object?> get props => [
        failure,
      ];
}

class UserBooksLoadedState extends UserBooksState {
  final List<BookEntity> books;

  UserBooksLoadedState({required this.books});

  @override
  List<Object?> get props => [
        books,
      ];
}
