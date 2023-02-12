import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';

abstract class BookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookNotLoadedState extends BookState {}

class BookLoadingState extends BookNotLoadedState {
  final BookState oldState;

  BookLoadingState({required this.oldState});

  @override
  List<Object?> get props => [
        oldState,
      ];
}

class BookLoadingFailedState extends BookNotLoadedState {
  final Failure failure;

  BookLoadingFailedState({required this.failure});

  @override
  List<Object?> get props => [
        failure,
      ];
}

class BookLoadedState extends BookState {
  final BookEntity book;

  BookLoadedState({required this.book});

  @override
  List<Object?> get props => [
        book,
      ];
}
