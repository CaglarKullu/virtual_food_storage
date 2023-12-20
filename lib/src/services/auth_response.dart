import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceAuthResponse {
  final User? user;
  final bool isSuccess;
  final String? errorMessage;

  ServiceAuthResponse.success({required this.user})
      : isSuccess = true,
        errorMessage = null;
  ServiceAuthResponse.failure({required this.errorMessage})
      : isSuccess = false,
        user = null;
}
