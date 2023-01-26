import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_cubit.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isObscurePasswordEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: _emailFieldKey,
            controller: _emailController,
            readOnly: _isPasswordVisible,
            autofocus: true,
            onFieldSubmitted: (String email) async {
              await _onEmailFieldSubmitted(context);
            },
            validator: _emailValidator,
            decoration: InputDecoration(
              label: const Text("Email"),
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.mail),
              suffixIcon: InkWell(
                onTap: _onEditEmail,
                child: const Icon(Icons.edit),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 100),
            child: _isPasswordVisible
                ? Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isObscurePasswordEnabled,
                        onFieldSubmitted: (String password) async {
                          await _onPasswordFieldSubmitted(context);
                        },
                        validator: _passwordValidator,
                        decoration: InputDecoration(
                          label: const Text("Password"),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.password),
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
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_isPasswordVisible) {
                await _authenticate(context);
              } else {
                await _getTemporaryPassword(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_isPasswordVisible ? "Sign In" : "Get password"),
            ),
          ),
        ],
      ),
    );
  }

  void _onEditEmail() {
    _reset();
  }

  Future<void> _onEmailFieldSubmitted(BuildContext context) async {
    await _getTemporaryPassword(context);
  }

  Future<void> _onPasswordFieldSubmitted(BuildContext context) async {
    await _authenticate(context);
  }

  Future<void> _authenticate(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthCubit>().authByCredentials(
            email: _emailController.text,
            password: _passwordController.text,
          );
      _reset();
    }
  }

  Future<void> _getTemporaryPassword(BuildContext context) async {
    if (_emailFieldKey.currentState!.validate()) {
      await context.read<AuthCubit>().getPassword(email: _emailController.text);
      setState(() {
        _isPasswordVisible = true;
      });
    }
  }

  void _reset() {
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _isPasswordVisible = false;
      _isObscurePasswordEnabled = true;
    });
  }

  String? _emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter email address";
    }
    if (!_isValidEmail(value)) {
      return "Please enter valid email address";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter password";
    }
    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }
}
