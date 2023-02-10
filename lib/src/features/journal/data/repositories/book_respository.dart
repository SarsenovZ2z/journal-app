import 'package:journal/src/features/journal/domain/entities/book_entity.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:journal/src/features/journal/domain/repositories/book_repository.dart';

class BookRepositoryImpl extends BookRepository {
  @override
  Future<Either<Failure, List<BookEntity>>> getCurrentUserBooks() async {
    return const Right([]);
  }
}
