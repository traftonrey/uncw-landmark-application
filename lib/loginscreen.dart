import 'package:flutter/material.dart';
import 'package:uncw_landmark_app/about_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  String? error;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Enter your email'),
                  maxLength: 64,
                  onChanged: (value) => email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null; // Returning null means "no issues"
                  }),
              TextFormField(
                  decoration:
                      const InputDecoration(hintText: "Enter a password"),
                  obscureText: true,
                  onChanged: (value) => password = value,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Your password must contain at least 8 characters.';
                    }
                    return null; // Returning null means "no issues"
                  }),
              const SizedBox(height: 16),
              ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Everything is valid. Try to login using Firebase Authentication.
                    }
                  }),
              if (error != null)
                Text(
                  "Error: $error",
                  style: TextStyle(color: Colors.red[800], fontSize: 12),
                )
            ],
          ),
        ),
      ),
    );
  }
}
