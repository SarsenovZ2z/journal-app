import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/presentation/bloc/book_cubit.dart';
import 'package:journal/src/locator.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as BookScreenArguments;

    return BlocProvider<BookCubit>(
      create: (context) => sl<BookCubit>()..loadBook(args.id),
      child: const Placeholder(),
    );
  }
}

class BookScreenArguments {
  final int id;

  BookScreenArguments({required this.id});
}
