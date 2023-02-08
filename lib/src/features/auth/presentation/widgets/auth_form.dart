import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/functions.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/auth_cubit.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/auth_states.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/password/password_cubit.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/password/password_states.dart';
import 'package:journal/src/locator.dart';

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
  bool _isObscurePasswordEnabled = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordCubit>(
      create: (context) => sl<PasswordCubit>(),
      child: Form(
        key: _formKey,
        child: BlocBuilder<PasswordCubit, PasswordState>(
            builder: (context, passwordState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: _emailFieldKey,
                enabled: !_isLoading,
                controller: _emailController,
                readOnly: passwordState is PasswordIssuedState,
                autofocus: passwordState is! PasswordIssuedState,
                onFieldSubmitted: (String email) async {
                  await _load(_getTemporaryPassword(context));
                },
                validator: (String? value) => _emailValidator(value, context),
                decoration: InputDecoration(
                  label: const Text("Email"),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.mail),
                  suffixIcon: InkWell(
                    onTap: () async {
                      _reset(context);
                    },
                    child: const Icon(Icons.edit),
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: passwordState is PasswordIssuedState
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, authState) => TextFormField(
                            enabled: !_isLoading,
                            controller: _passwordController,
                            obscureText: _isObscurePasswordEnabled,
                            onFieldSubmitted: (String password) async {
                              await _load(_authenticate(context));
                            },
                            validator: (String? value) =>
                                _passwordValidator(value, context),
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
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        await _load(passwordState is PasswordIssuedState
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
                      : Text(passwordState is PasswordIssuedState
                          ? "Sign In"
                          : "Get password"),
                ),
              ),
            ],
          );
        }),
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

  Future<void> _authenticate(BuildContext context) async {
    final AuthCubit authCubit = context.read<AuthCubit>();
    authCubit.forgetLastError();
    if (_formKey.currentState!.validate()) {
      await delay();
      await authCubit.authByCredentials(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (authCubit.state is AuthenticationFailedState) {
        _formKey.currentState?.validate();
      }
    }
  }

  Future<void> _getTemporaryPassword(BuildContext context) async {
    final passwordCubit = context.read<PasswordCubit>();
    if (_emailFieldKey.currentState!.validate()) {
      await delay();
      await passwordCubit.getPassword(email: _emailController.text);
      if (passwordCubit.state is PasswordRequestFailedState) {
        _emailFieldKey.currentState?.validate();
      } else if (passwordCubit.state is PasswordIssuedState) {
        // set focus
      }
    }
  }

  void _reset(BuildContext context) {
    _emailController.clear();
    _passwordController.clear();

    context.read<PasswordCubit>().reset();
    setState(() {
      _isObscurePasswordEnabled = true;
    });
  }

  String? _emailValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "Enter email address";
    }
    if (!_isValidEmail(value)) {
      return "Please enter valid email address";
    }

    final PasswordCubit passwordCubit = context.read<PasswordCubit>();
    final PasswordState passwordState = passwordCubit.state;
    if (passwordState is PasswordRequestFailedState) {
      passwordCubit.forgetLastError();
      return passwordState.failure.message;
    }

    return null;
  }

  String? _passwordValidator(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return "Enter password";
    }

    final AuthCubit authCubit = context.read<AuthCubit>();
    final AuthState authState = authCubit.state;

    if (authState is AuthenticationFailedState) {
      authCubit.forgetLastError();
      return authState.failure.message;
    }

    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }
}
