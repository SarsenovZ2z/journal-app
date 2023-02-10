import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/journal/domain/usecases/get_current_user_books.dart';
import 'package:journal/src/features/journal/presentation/bloc/book/current_user_books_states.dart';

class CurrentUserBooksCubit extends Cubit<CurrentUserBooksState> {
  final GetCurrentUserBooks getCurrentUserBooks;

  CurrentUserBooksCubit({
    required this.getCurrentUserBooks,
  }) : super(CurrentUserBooksNotLoadedState());

  Future<void> loadCurrentUserBooks() async {
    if (state is CurrentUserBooksLoadingState) {
      return;
    }

    emit(CurrentUserBooksLoadingState());
    final failureOrBookEntities =
        await getCurrentUserBooks(GetCurrentUserBooksParams());

    failureOrBookEntities.fold((error) {
      emit(CurrentUserBooksLoadFailedState(failure: error));
    }, (bookEntities) {
      emit(CurrentUserBooksLoadedState(books: bookEntities));
    });
  }
}
