import 'package:journal/src/features/journal/data/datasources/book_data_source.dart';
import 'package:journal/src/features/journal/domain/entities/book_entity.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:journal/src/features/journal/domain/repositories/book_repository.dart';

class BookRepositoryImpl extends BookRepository {
  final BookDataSource bookDataSource;

  BookRepositoryImpl({required this.bookDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> getCurrentUserBooks() async {
    try {
      return Right(await bookDataSource.getCurrentUserBooks());
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
