import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/auth_cubit.dart';
import 'package:journal/src/features/auth/presentation/bloc/Auth/auth_states.dart';
import 'package:journal/src/features/auth/presentation/pages/auth_screen.dart';
import 'package:journal/src/features/journal/presentation/pages/loading_screen.dart';

class OnlyAuthenticatedScreen extends StatelessWidget {
  final Widget child;

  const OnlyAuthenticatedScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatingByTokenState || state is LoggingOutState) {
          return const LoadingScreen();
        }

        if (state is NotAuthenticatedState) {
          return const AuthScreen();
        }

        return child;
      },
    );
  }
}
