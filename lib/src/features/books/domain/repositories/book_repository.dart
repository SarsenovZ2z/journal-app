import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getCurrentUserBooks();

  Future<Either<Failure, BookEntity>> getBook(int id);

  Future<Either<Failure, BookEntity>> createBook(
      String name, String password, dynamic image);
}
