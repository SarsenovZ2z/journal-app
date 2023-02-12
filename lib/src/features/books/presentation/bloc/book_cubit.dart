import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/domain/usecases/get_book.dart';
import 'package:journal/src/features/books/presentation/bloc/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetBook getBook;

  BookCubit({
    required this.getBook,
  }) : super(BookNotLoadedState());

  Future<void> loadBook(int id) async {
    if (state is BookLoadingState) {
      return;
    }

    emit(BookLoadingState(oldState: state));
    final failureOrBook = await getBook(GetBookParams(id: id));
    failureOrBook.fold((failure) {
      emit(BookLoadingFailedState(failure: failure));
    }, (book) {
      emit(BookLoadedState(book: book));
    });
  }
}
