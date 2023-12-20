import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/src/providers/supabase_client_provider.dart';
import 'package:virtual_food_storage/src/services/i_user_backend.dart';
import '../controllers/user_controller.dart';
import '../state/user_state.dart';

final userProvider = StateNotifierProvider<UserController, UserState>((ref) {
  return UserController(
      ref.read(subabaseClientProvider as ProviderListenable<IUserBackend>));
});
