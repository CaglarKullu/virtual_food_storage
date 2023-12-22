import 'package:virtual_food_storage/src/utils/auth_response.dart';

abstract class IUserBackend {
  Future<ServiceAuthResponse> signIn(
      {required String email, required String password});
  Future<ServiceAuthResponse> signUp(
      {required String email, required String password});
  Future<void> signOut();
  Future<void> resetPassword({required String email});
  // Add other necessary backend methods here
}
