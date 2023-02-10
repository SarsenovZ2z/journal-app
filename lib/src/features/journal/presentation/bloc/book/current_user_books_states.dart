// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';

import 'package:journal/src/features/journal/domain/entities/book_entity.dart';

abstract class CurrentUserBooksState extends Equatable {}

class CurrentUserBooksNotLoadedState extends CurrentUserBooksState {
  @override
  List<Object?> get props => [];
}

class CurrentUserBooksLoadFailedState extends CurrentUserBooksNotLoadedState {
  final Failure failure;

  CurrentUserBooksLoadFailedState({required this.failure});
}

class CurrentUserBooksLoadingState extends CurrentUserBooksNotLoadedState {}

class CurrentUserBooksLoadedState extends CurrentUserBooksState {
  final List<BookEntity> books;

  CurrentUserBooksLoadedState({
    required this.books,
  });

  @override
  List<Object?> get props => [
        books,
      ];
}
