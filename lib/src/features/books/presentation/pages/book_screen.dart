import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/presentation/bloc/book_cubit.dart';
import 'package:journal/src/features/books/presentation/bloc/book_state.dart';
import 'package:journal/src/locator.dart';

class BookScreen extends StatelessWidget {
  final int id;

  const BookScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookCubit>(
      create: (context) => sl<BookCubit>()..loadBook(id),
      child: BlocBuilder<BookCubit, BookState>(
        builder: (context, bookState) => RefreshIndicator(
          onRefresh: () async {
            await context.read<BookCubit>().loadBook(id);
          },
          child: Scaffold(
            body: _bookWrapper(context, bookState),
          ),
        ),
      ),
    );
  }

  Widget _bookWrapper(BuildContext context, BookState state) {
    if (state is BookLoadingState) {
      state = state.oldState;
    }

    if (state is BookLoadedState) {
      return ListView(
        children: [
          Text(state.book.name),
        ],
      );
    }

    if (state is BookLoadingFailedState) {
      return Center(child: Text(state.failure.message));
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
