import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:virtual_food_storage/src/models/user.dart';
import 'package:virtual_food_storage/src/utils/auth_response.dart';

import '../interfaces/i_user_backend.dart';

class SupabaseBackend implements IUserBackend {
  final SupabaseClient _supabaseClient;

  SupabaseBackend(this._supabaseClient);

  @override
  Future<void> resetPassword({required String email}) async {
    await _supabaseClient.auth.resetPasswordForEmail(email).onError(
        (error, stackTrace) =>
            throw Exception('Password reset failed: ${error?.toString()}'));
  }

  @override
  Future<ServiceAuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        return ServiceAuthResponse.failure(errorMessage: response.toString());
      }
      if (response.user != null) {
        final user = AppUser.fromSupabaseUser(response.user!);
        return ServiceAuthResponse.success(user: user);
      }
      return ServiceAuthResponse.failure(
          errorMessage: 'Unknown error occurred');
    } catch (e) {
      return ServiceAuthResponse.failure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut().onError((error, stackTrace) =>
        throw Exception('Sign out failed: ${error.toString()}'));
  }

  @override
  Future<ServiceAuthResponse> signUp(
      {required String email, required String password}) async {
    try {
      final response =
          await _supabaseClient.auth.signUp(email: email, password: password);
      if (response.user == null) {
        return ServiceAuthResponse.failure(errorMessage: response.toString());
      }
      if (response.user != null) {
        final user = AppUser.fromSupabaseUser(response.user!);
        return ServiceAuthResponse.success(user: user);
      }
      return ServiceAuthResponse.failure(
          errorMessage: 'Unknown error occurred');
    } catch (e) {
      return ServiceAuthResponse.failure(errorMessage: e.toString());
    }
  }
}
