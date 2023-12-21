import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user_controller.dart';
import '../providers/user_provider.dart';
import '../state/user_state.dart';

class SignUpView extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.watch(userProvider.notifier);
    final userState = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmailFormField(),
              const SizedBox(height: 16.0),
              _buildPasswordFormField(),
              const SizedBox(height: 24.0),
              _buildSignUpButton(context, userController, userState),
              _buildLoginButton(context),
              if (userState.status == UserStateStatus.loading)
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
          labelText: 'Email', border: OutlineInputBorder()),
      keyboardType: TextInputType.emailAddress,
      validator: (value) =>
          value != null && value.contains('@') ? null : 'Enter a valid email',
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
          labelText: 'Password', border: OutlineInputBorder()),
      obscureText: true,
      validator: (value) => value != null && value.length >= 6
          ? null
          : 'Enter at least 6 characters',
    );
  }

  ElevatedButton _buildSignUpButton(BuildContext context,
      UserController userController, UserState userState) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            await userController.signUp(
                _emailController.text, _passwordController.text);
            if (!context.mounted) return;
            Navigator.popAndPushNamed(context, '/login');
          } on Exception catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      },
      child: const Text('Sign Up'),
    );
  }

  TextButton _buildLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/login'),
      child: const Text('Already have an account? Login'),
    );
  }
}
