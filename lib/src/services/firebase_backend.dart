import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_food_storage/src/services/auth_response.dart';
import '../models/user.dart';
import 'i_user_backend.dart';

class FirebaseBackend implements IUserBackend {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseBackend(this._firebaseAuth, this._firestore);

  @override
  Future<ServiceAuthResponse> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final user = AppUser.fromFirebaseUser(
            firebaseUser); // Convert to your User model
        return ServiceAuthResponse.success(user: user);
      }
      return ServiceAuthResponse.failure(errorMessage: 'User not found');
    } catch (e) {
      return ServiceAuthResponse.failure(errorMessage: e.toString());
    }
  }

  @override
  Future<ServiceAuthResponse> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // add user to Firestore
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'email': email,
          // other user details
        });
        final user = AppUser.fromFirebaseUser(firebaseUser);
        // Convert to your User model
        final response =
            ServiceAuthResponse.success(user: user, isNewUser: true);

        return response;
      }
      return ServiceAuthResponse.failure(errorMessage: 'Registration failed');
    } catch (e) {
      return ServiceAuthResponse.failure(errorMessage: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent successfully';
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }
}
