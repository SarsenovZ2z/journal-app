import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/domain/usecases/create_book.dart';
import 'package:journal/src/features/books/presentation/bloc/create_book_states.dart';
import 'package:journal/src/functions.dart';

class CreateBookCubit extends Cubit<CreateBookState> {
  final CreateBook createBook;

  CreateBookCubit({
    required this.createBook,
  }) : super(CreateBookNotCreatedState());

  Future<void> create({
    required String name,
    required String password,
    dynamic image,
  }) async {
    if (state is CreateBookLoadingState) {
      return;
    }

    emit(CreateBookLoadingState());
    await delay();
    final failureOrBook = await createBook(CreateBookParams(
      name: name,
      password: password,
      image: image,
    ));

    failureOrBook.fold((error) {
      emit(CreateBookFailedState(failure: error));
    }, (book) {
      emit(CreateBookCreatedState(book: book));
    });
  }
}
