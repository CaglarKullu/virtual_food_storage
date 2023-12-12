import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum UserStateStatus { initial, loading, success, error }

@immutable
class UserState {
  final UserStateStatus status;
  final User? user;
  final String? errorMessage;

  const UserState(
      {this.status = UserStateStatus.initial, this.user, this.errorMessage});

  UserState copyWith(
      {UserStateStatus? status, User? user, String? errorMessage}) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
