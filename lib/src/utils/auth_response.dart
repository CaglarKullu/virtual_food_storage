import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtual_food_storage/src/models/user.dart';

@immutable
class ServiceAuthResponse {
  final AppUser? user;
  final bool isSuccess;
  final String? errorMessage;
  final bool isNewUser;

  const ServiceAuthResponse(
      {this.user,
      this.isSuccess = false,
      this.errorMessage,
      this.isNewUser = false});

  ServiceAuthResponse copyWith({
    AppUser? user,
    bool? isSuccess,
    String? errorMessage,
    bool? isNewUser,
  }) {
    return ServiceAuthResponse(
      user: user ?? this.user,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      isNewUser: isNewUser ?? this.isNewUser,
    );
  }

  // Success response
  factory ServiceAuthResponse.success(
      {required AppUser user, bool isNewUser = false}) {
    return ServiceAuthResponse(
        user: user, isSuccess: true, isNewUser: isNewUser);
  }

  // Failure response
  factory ServiceAuthResponse.failure({required String errorMessage}) {
    return ServiceAuthResponse(
      errorMessage: errorMessage,
      isSuccess: false,
    );
  }

  // Factory constructor for creating an AuthResponse from UserCredential
  factory ServiceAuthResponse.fromUserCredential(UserCredential credential) {
    if (credential.user != null) {
      return ServiceAuthResponse.success(
          user: AppUser.fromFirebaseUser(credential.user!),
          isNewUser: credential.additionalUserInfo?.isNewUser ?? false);
    } else {
      return ServiceAuthResponse.failure(errorMessage: 'Authentication failed');
    }
  }
}
