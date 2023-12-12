import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:virtual_food_storage/providers/supabase_client_provider.dart';
import 'package:virtual_food_storage/state/user_state.dart';

import '../controllers/user_controller.dart';

final userProvider = StateNotifierProvider<UserController, UserState>((ref) {
  return UserController(ref.read(subabaseClientProvider));
});
