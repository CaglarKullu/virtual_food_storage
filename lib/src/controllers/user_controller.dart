import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/src/services/auth_response.dart';
import '../services/i_user_backend.dart';
import '../state/user_state.dart';

class UserController extends StateNotifier<UserState> {
  final IUserBackend _backend;

  UserController(this._backend) : super(const UserState());

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(status: UserStateStatus.loading);
    final ServiceAuthResponse response =
        await _backend.signUp(email: email, password: password);
    if (response.isSuccess) {
      state =
          state.copyWith(status: UserStateStatus.success, user: response.user);
    } else {
      state = state.copyWith(
          status: UserStateStatus.error, errorMessage: response.errorMessage);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: UserStateStatus.loading);

    final ServiceAuthResponse response =
        await _backend.signIn(email: email, password: password);

    if (response.isSuccess) {
      state =
          state.copyWith(status: UserStateStatus.success, user: response.user);
    } else {
      state = state.copyWith(
          status: UserStateStatus.error, errorMessage: response.errorMessage);
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(status: UserStateStatus.loading);
    try {
      await _backend.signOut();
      state = state.copyWith(status: UserStateStatus.initial, user: null);
    } catch (e) {
      state = state.copyWith(
          status: UserStateStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    await _backend.resetPassword(email: email).onError((error, stackTrace) =>
        throw Exception(
            'Password reset failed: ${error.toString() + stackTrace.toString()}'));
  }
}
