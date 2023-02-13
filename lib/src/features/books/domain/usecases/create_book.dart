import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';
import 'package:journal/src/features/books/domain/repositories/book_repository.dart';

class CreateBook
    extends UseCase<Either<Failure, BookEntity>, CreateBookParams> {
  final BookRepository bookRepository;

  CreateBook({required this.bookRepository});

  @override
  Future<Either<Failure, BookEntity>> call(CreateBookParams params) async {
    return bookRepository.createBook(
        params.name, params.password, params.image);
  }
}

class CreateBookParams {
  final String name;
  final String password;
  final dynamic image;

  CreateBookParams({required this.name, required this.password, this.image});
}
