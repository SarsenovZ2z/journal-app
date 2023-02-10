import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/journal/domain/usecases/get_current_user_books.dart';
import 'package:journal/src/features/journal/presentation/bloc/book/user_books_states.dart';
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

    emit(UserBooksLoadingState());

    await delay();

    final failureOrBookEntities =
        await getCurrentUserBooks(GetCurrentUserBooksParams());

    failureOrBookEntities.fold((error) {
      emit(UserBooksLoadFailedState(failure: error));
    }, (bookEntities) {
      emit(UserBooksLoadedState(books: bookEntities));
    });
  }
}
