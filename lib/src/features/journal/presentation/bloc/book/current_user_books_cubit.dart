import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/journal/presentation/bloc/book/current_user_books_states.dart';

class CurrentUserBooksCubit extends Cubit<CurrentUserBooksState> {
  CurrentUserBooksCubit() : super(CurrentUserBooksNotLoadedState());

  Future<void> loadCurrentUserBooks() async {}
}
