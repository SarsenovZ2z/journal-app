import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/domain/entities/book_entity.dart';
import 'package:journal/src/features/books/presentation/bloc/user_books_cubit.dart';
import 'package:journal/src/features/books/presentation/bloc/user_books_states.dart';
import 'package:journal/src/features/books/presentation/pages/book_screen.dart';
import 'package:journal/src/locator.dart';

class BooksScreen extends StatelessWidget {
  static const routeName = '/';

  const BooksScreen({super.key});

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
                child: GridView.builder(
                  padding: const EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount:
                        (MediaQuery.of(context).size.width / 300).ceil(),
                  ),
                  itemCount: userBooksState.books.length,
                  itemBuilder: (context, index) =>
                      _Book(book: userBooksState.books[index]),
                ),
              );
            }

            if (userBooksState is UserBooksLoadFailedState) {
              return Center(child: Text(userBooksState.failure.message));
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
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/book/${book.id}');
      },
      child: Card(
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Theme.of(context).cardColor,
            title: Text(
              book.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(book.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
