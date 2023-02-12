import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/domain/usecases/get_current_user_books.dart';
import 'package:journal/src/features/books/presentation/bloc/user_books_states.dart';
import 'package:journal/src/functions.dart';

class UserBooksCubit extends Cubit<UserBooksState> {
  final GetCurrentUserBooks getCurrentUserBooks;

  UserBooksCubit({
    required this.getCurrentUserBooks,
  }) : super(UserBooksNotLoadedState());

  Future<void> loadCurrentUserBooks() async {
    if (state is UserBooksLoadingState) {
      return;
    }

    emit(UserBooksLoadingState(oldState: state));

    await delay();

    final failureOrBooks =
        await getCurrentUserBooks(GetCurrentUserBooksParams());

    failureOrBooks.fold((error) {
      emit(UserBooksLoadFailedState(failure: error));
    }, (books) {
      emit(UserBooksLoadedState(books: books));
    });
  }
}
