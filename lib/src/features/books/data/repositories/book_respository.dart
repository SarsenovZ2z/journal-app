import 'package:journal/src/features/books/data/datasources/book_data_source.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:journal/src/features/books/domain/repositories/book_repository.dart';

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

  @override
  Future<Either<Failure, BookEntity>> getBook(int id) async {
    try {
      return Right(await bookDataSource.getBook(id));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> createBook(
      String name, String password, dynamic image) async {
    try {
      return Right(await bookDataSource.createBook(name, password, image));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
