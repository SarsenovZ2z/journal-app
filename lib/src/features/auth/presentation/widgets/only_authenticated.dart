import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:journal/src/features/auth/presentation/bloc/auth/auth_states.dart';
import 'package:journal/src/features/auth/presentation/pages/auth_screen.dart';
import 'package:journal/src/features/auth/presentation/pages/loading_screen.dart';

class OnlyAuthenticated extends StatelessWidget {
  final Widget authForm;
  final Widget loading;
  final Widget child;

  const OnlyAuthenticated({
    super.key,
    required this.child,
    this.authForm = const AuthScreen(),
    this.loading = const LoadingScreen(),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatingByTokenState || state is LoggingOutState) {
          return loading;
        }

        if (state is NotAuthenticatedState) {
          return authForm;
        }

        return child;
      },
    );
  }
}
