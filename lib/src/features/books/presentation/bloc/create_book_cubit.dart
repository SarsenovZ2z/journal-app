import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/core/error/failures.dart';
import 'package:journal/src/features/books/presentation/bloc/create_book_states.dart';
import 'package:journal/src/functions.dart';

class CreateBookCubit extends Cubit<CreateBookState> {
  CreateBookCubit() : super(CreateBookNotCreatedState());

  Future<void> createBook() async {
    if (state is CreateBookLoadingState) {
      return;
    }

    emit(CreateBookLoadingState());
    await delay();
    emit(CreateBookFailedState(failure: const NetworkFailure('Test failure')));
  }
}
