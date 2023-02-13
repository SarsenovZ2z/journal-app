import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscurePasswordEnabled,
              decoration: InputDecoration(
                label: const Text('Password'),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _isObscurePasswordEnabled = !_isObscurePasswordEnabled;
                    });
                  },
                  child: Icon(_isObscurePasswordEnabled
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
