import 'package:equatable/equatable.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';

abstract class CreateBookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateBookNotCreatedState extends CreateBookState {}

class CreateBookLoadingState extends CreateBookNotCreatedState {}

class CreateBookFailedState extends CreateBookNotCreatedState {
  final Failure failure;

  CreateBookFailedState({required this.failure});

  @override
  List<Object?> get props => [
        failure,
      ];
}

class CreateBookCreatedState extends CreateBookState {
  final BookEntity book;

  CreateBookCreatedState({required this.book});

  @override
  List<Object?> get props => [
        book,
      ];
}
