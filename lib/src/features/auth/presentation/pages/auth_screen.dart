import 'package:flutter/material.dart';
import 'package:journal/src/features/auth/presentation/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Sign in',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const AuthForm(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
