// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';

import 'package:journal/src/features/journal/domain/entities/book_entity.dart';

abstract class UserBooksState extends Equatable {}

class UserBooksNotLoadedState extends UserBooksState {
  @override
  List<Object?> get props => [];
}

class UserBooksLoadFailedState extends UserBooksNotLoadedState {
  final Failure failure;

  UserBooksLoadFailedState({required this.failure});
}

class UserBooksLoadingState extends UserBooksNotLoadedState {}

class UserBooksLoadedState extends UserBooksState {
  final List<BookEntity> books;

  UserBooksLoadedState({
    required this.books,
  });

  @override
  List<Object?> get props => [
        books,
      ];
}
