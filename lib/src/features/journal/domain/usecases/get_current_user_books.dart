import 'package:dartz/dartz.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/core/usecase.dart';
import 'package:journal/src/features/journal/domain/entities/book_entity.dart';
import 'package:journal/src/features/journal/domain/repositories/book_repository.dart';

class GetCurrentUserBooks extends UseCase<Either<Failure, List<BookEntity>>,
    GetCurrentUserBooksParams> {
  final BookRepository bookRepository;

  GetCurrentUserBooks({required this.bookRepository});

  @override
  Future<Either<Failure, List<BookEntity>>> call(
      GetCurrentUserBooksParams params) async {
    return bookRepository.getCurrentUserBooks();
  }
}

class GetCurrentUserBooksParams {}
