import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.dart' as ourUser;

class UserController extends StateNotifier<ourUser.User?> {
  final SupabaseClient _supabaseClient;

  UserController(this._supabaseClient) : super(null);

  Future<void> signUp(String email, String password) async {
    final response =
        await _supabaseClient.auth.signUp(password: password, email: email);
    if (response.user != null) {
      final appUser = User.fromJson(response.user!.toJson());
      state = appUser as ourUser.User?;
    } else {
      throw Exception('Sign Up failed: ${response.toString()}');
    }
  }

  Future<void> signIn(String email, String password) async {
    final response = await _supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    if (response.user != null) {
      final appUser = User.fromJson(response.user!.toJson());
      state = appUser as ourUser.User?;
    } else {
      throw Exception('Sign In failed: ${response.toString()}');
    }
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    state = null;
  }

  Future<void> resetPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email).onError(
        (error, stackTrace) => throw Exception(
            'Password reset failed: ${error.toString() + stackTrace.toString()}'));
  }
}
