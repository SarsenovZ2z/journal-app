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
      child: Scaffold(
        body: BlocBuilder<BookCubit, BookState>(
          builder: (context, bookState) {
            if (bookState is BookLoadingState) {
              bookState = bookState.oldState;
            }

            if (bookState is BookLoadedState) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<BookCubit>().loadBook(id);
                },
                child: ListView(
                  children: [
                    Text(bookState.book.name),
                  ],
                ),
              );
            }

            if (bookState is BookLoadingFailedState) {
              return Center(child: Text(bookState.failure.message));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
