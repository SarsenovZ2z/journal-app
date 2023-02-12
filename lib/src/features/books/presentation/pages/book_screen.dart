import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/presentation/bloc/book_cubit.dart';
import 'package:journal/src/locator.dart';

class BookScreen extends StatelessWidget {
  final int id;

  const BookScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookCubit>(
      create: (context) => sl<BookCubit>()..loadBook(id),
      child: const Placeholder(),
    );
  }
}
