import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/features/journal/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getCurrentUserBooks();
}
