import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../state/user_state.dart';

class UserController extends StateNotifier<UserState> {
  final SupabaseClient _supabaseClient;

  UserController(this._supabaseClient) : super(const UserState());

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(status: UserStateStatus.loading);
    try {
      final response =
          await _supabaseClient.auth.signUp(password: password, email: email);
      if (response.user != null) {
        final appUser = User.fromJson(response.user!.toJson());
        state = state.copyWith(status: UserStateStatus.initial, user: appUser);
      } else {
        state = state.copyWith(
            status: UserStateStatus.error, errorMessage: response.toString());
        throw Exception('Sign Up failed: ${response.toString()}');
      }
    } catch (e) {
      state = state.copyWith(
          status: UserStateStatus.error, errorMessage: e.toString());
      throw Exception('Sign Up failed: ${e.toString()}');
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: UserStateStatus.loading);
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password)
          .onError((error, stackTrace) {
        state = state.copyWith(
            status: UserStateStatus.error, errorMessage: error.toString());
        throw Exception('Sign In failed: ${error.toString()}');
      });
      if (response.user != null) {
        final appUser = User.fromJson(response.user!.toJson());
        state = state.copyWith(status: UserStateStatus.success, user: appUser);
      }
    } catch (e) {
      state =
          UserState(status: UserStateStatus.error, errorMessage: e.toString());
      throw Exception('Sign In failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    state = state.copyWith(status: UserStateStatus.initial);
  }

  Future<void> resetPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email).onError(
        (error, stackTrace) => throw Exception(
            'Password reset failed: ${error.toString() + stackTrace.toString()}'));
  }
}
