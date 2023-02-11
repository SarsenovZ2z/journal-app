import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/presentation/bloc/book_state.dart';
import 'package:journal/src/functions.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookNotLoadedState());

  Future<void> loadBook(int id) async {
    if (state is BookLoadingState) {
      return;
    }

    emit(BookLoadingState());
    await delay();
    emit(BookLoadedState());
  }
}
