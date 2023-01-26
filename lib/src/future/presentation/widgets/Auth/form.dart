import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/functions.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_cubit.dart';
import 'package:journal/src/future/presentation/bloc/Auth/auth_states.dart';

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

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isObscurePasswordEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  return TextFormField(
                    key: _emailFieldKey,
                    enabled: !_isLoading,
                    controller: _emailController,
                    readOnly: _isPasswordVisible,
                    autofocus: !_isPasswordVisible,
                    onFieldSubmitted: (String email) async {
                      await _load(_onEmailFieldSubmitted(context));
                    },
                    onChanged: (String password) async {
                      if (state is AuthenticationFailedState) {
                        context.read<AuthCubit>().forgetLastError();
                      }
                    },
                    autovalidateMode: AutovalidateMode.always,
                    validator: (String? value) =>
                        state is AuthenticationFailedState
                            ? state.errorMessage
                            : _emailValidator(value),
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.mail),
                      suffixIcon: InkWell(
                        onTap: () async {
                          await _onEditEmail(context);
                        },
                        child: const Icon(Icons.edit),
                      ),
                    ),
                  );
                }),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: _isPasswordVisible
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) => TextFormField(
                                enabled: !_isLoading,
                                controller: _passwordController,
                                obscureText: _isObscurePasswordEnabled,
                                autofocus: _isPasswordVisible,
                                onFieldSubmitted: (String password) async {
                                  await _load(
                                      _onPasswordFieldSubmitted(context));
                                },
                                onChanged: (String password) async {
                                  if (state is AuthenticationFailedState) {
                                    context.read<AuthCubit>().forgetLastError();
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (String? value) =>
                                    state is AuthenticationFailedState
                                        ? state.errorMessage
                                        : _passwordValidator(value),
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
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          await _load(_isPasswordVisible
                              ? _authenticate(context)
                              : _getTemporaryPassword(context));
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
                        : Text(_isPasswordVisible ? "Sign In" : "Get password"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  Future<void> _onEditEmail(BuildContext context) async {
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
      await slowAwait<void>(
        f: context.read<AuthCubit>().authByCredentials(
              email: _emailController.text,
              password: _passwordController.text,
            ),
      );
    }
  }

  Future<void> _getTemporaryPassword(BuildContext context) async {
    if (_emailFieldKey.currentState!.validate()) {
      await slowAwait(
        f: context.read<AuthCubit>().getPassword(email: _emailController.text),
      );
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
