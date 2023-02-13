import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/books/presentation/bloc/book_cubit.dart';
import 'package:journal/src/features/books/presentation/bloc/create_book_cubit.dart';
import 'package:journal/src/features/books/presentation/bloc/create_book_states.dart';
import 'package:journal/src/functions.dart';
import 'package:journal/src/locator.dart';

class CreateBookForm extends StatefulWidget {
  const CreateBookForm({super.key});

  @override
  State<CreateBookForm> createState() => _CreateBookFormState();
}

class _CreateBookFormState extends State<CreateBookForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscurePasswordEnabled = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateBookCubit>(
      create: (context) => sl<CreateBookCubit>(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: BlocBuilder<CreateBookCubit, CreateBookState>(
                    builder: (context, createBookState) {
                  return Column(
                    children: [
                      Container(
                        child: Placeholder(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _nameController,
                        enabled: !_isLoading,
                        validator: (String? value) =>
                            _nameValidator(value, context),
                        decoration: const InputDecoration(
                          label: Text('Name'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        enabled: !_isLoading,
                        obscureText: _isObscurePasswordEnabled,
                        validator: (String? value) =>
                            _passwordValidator(value, context),
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isObscurePasswordEnabled =
                                    !_isObscurePasswordEnabled;
                              });
                            },
                            child: Icon(_isObscurePasswordEnabled
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                await _load(_createBook(context));
                              },
                        child: Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(minHeight: 50),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Submit'),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _load(Future f) async {
    setState(() {
      _isLoading = true;
      _isObscurePasswordEnabled = true;
    });

    await f;

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createBook(BuildContext context) async {
    final CreateBookCubit createBookCubit = context.read<CreateBookCubit>();

    if (_formKey.currentState!.validate()) {
      await delay();
    }
  }

  String? _nameValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "Enter name";
    }

    return null;
  }

  String? _passwordValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "Enter password";
    }

    return null;
  }
}
