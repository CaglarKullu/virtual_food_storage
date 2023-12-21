import 'package:flutter/material.dart';
import 'package:virtual_food_storage/src/models/user.dart';

enum UserStateStatus { initial, loading, success, error }

@immutable
class UserState {
  final UserStateStatus status;
  final AppUser? user;
  final String? errorMessage;

  const UserState(
      {this.status = UserStateStatus.initial, this.user, this.errorMessage});

  UserState copyWith(
      {UserStateStatus? status, AppUser? user, String? errorMessage}) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
