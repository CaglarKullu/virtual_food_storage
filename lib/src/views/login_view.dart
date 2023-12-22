import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/user_controller.dart';
import '../providers/user_provider.dart';
import '../state/user_state.dart';
import '../utils/email_Validator.dart';
import '../utils/error_snackbar.dart';

class LoginView extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = ref.read(userProvider.notifier);
    final userState = ref.watch(userProvider);
    log(userState.status.toString());

    switch (userState.status) {
      case UserStateStatus.loading:
        return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()));
      case UserStateStatus.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSnackBar(
              context: context, error: userState.errorMessage.toString());
        });
        // Fall through to default to build the form
        return _buildLoginForm(context, userController, userState);
      default:
        return _buildLoginForm(context, userController, userState);
    }
  }

  Widget _buildLoginForm(BuildContext context, UserController userController,
      UserState userState) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              _buildLoginButton(context, userController, userState),
              const SizedBox(height: 24.0),
              _buildSignUpButton(context),
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
      validator: EmailValidator.validate,
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

  ElevatedButton _buildLoginButton(BuildContext context,
      UserController userController, UserState userState) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await userController
              .signIn(_emailController.text, _passwordController.text)
              .whenComplete(() {
            if (!context.mounted ||
                userState.status != UserStateStatus.success) {
              return;
            }
            Navigator.popAndPushNamed(context, '/dashboard');
          }).onError((error, stackTrace) =>
                  showSnackBar(context: context, error: error.toString()));
        }
      },
      child: const Text('Login'),
    );
  }

  TextButton _buildSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.popAndPushNamed(context, '/signup'),
      child: const Text('Do you need an account? Sign Up'),
    );
  }
}
