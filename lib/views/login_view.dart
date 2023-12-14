import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/utils/error_snackBar.dart';
import '../providers/user_provider.dart';
import '../state/user_state.dart';
import '../utils/email_Validator.dart';

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
    return switch (userState.status) {
      UserStateStatus.loading => const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        ),
      UserStateStatus.error =>
        showSnackBar(context: context, error: userState.errorMessage.toString())
            as Widget,
      _ => Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                    validator: EmailValidator.validate,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    obscureText: true,
                    validator: (value) => value != null && value.length >= 6
                        ? null
                        : 'Enter at least 6 characters',
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await userController
                            .signIn(
                                _emailController.text, _passwordController.text)
                            .whenComplete(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Login successful')));
                          if (!context.mounted ||
                              (userState.status == UserStateStatus.error) ||
                              (userState.status == UserStateStatus.initial)) {
                            return;
                          }
                          Navigator.popAndPushNamed(context, '/dashboard');
                        }).onError((error, stackTrace) => showSnackBar(
                                context: context, error: error.toString()));
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
    };
  }
}
