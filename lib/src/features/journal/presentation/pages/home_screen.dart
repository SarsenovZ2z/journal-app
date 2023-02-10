import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/journal/domain/entities/book_entity.dart';
import 'package:journal/src/features/journal/presentation/bloc/book/user_books_cubit.dart';
import 'package:journal/src/features/journal/presentation/bloc/book/user_books_states.dart';
import 'package:journal/src/locator.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBooksCubit>(
      create: (context) => sl<UserBooksCubit>()..loadCurrentUserBooks(),
      child: Scaffold(
        body: BlocBuilder<UserBooksCubit, UserBooksState>(
          builder: (context, userBooksState) {
            if (userBooksState is UserBooksLoadedState) {
              return RefreshIndicator(
                onRefresh: context.read<UserBooksCubit>().loadCurrentUserBooks,
                child: ListView(
                  children: [
                    Column(
                      children: userBooksState.books
                          .map((book) => _Book(book: book))
                          .toList(),
                    ),
                  ],
                ),
              );
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

class _Book extends StatelessWidget {
  final BookEntity book;

  const _Book({required this.book});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
