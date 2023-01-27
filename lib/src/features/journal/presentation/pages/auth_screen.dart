import 'package:flutter/material.dart';
import 'package:journal/src/features/journal/presentation/widgets/Auth/form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: const AuthForm(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
