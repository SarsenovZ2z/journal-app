import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';
import 'package:journal/src/features/books/domain/repositories/book_repository.dart';

class GetBook extends UseCase<Either<Failure, BookEntity>, GetBookParams> {
  final BookRepository bookRepository;

  GetBook({required this.bookRepository});

  @override
  Future<Either<Failure, BookEntity>> call(params) async {
    return bookRepository.getBook(params.id);
  }
}

class GetBookParams {
  final int id;

  GetBookParams({required this.id});
}
