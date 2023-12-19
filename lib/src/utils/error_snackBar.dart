import 'package:flutter/material.dart';

void showSnackBar({required String error, required BuildContext context}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Error: $error')));
}
