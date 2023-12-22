import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/interfaces/i_vault_backend.dart';
import '../state/vault_state.dart';

class VaultController extends StateNotifier<VaultState> {
  final IVaultBackend _backend;

  VaultController(this._backend) : super(const VaultState());

  Future<void> fetchVaults(String userId) async {
    state = state.copyWith(status: VaultStatus.loading);
    try {
      final vaults = await _backend.fetchVaults(userId);
      state = state.copyWith(status: VaultStatus.success, vaults: vaults);
    } catch (e) {
      state =
          state.copyWith(status: VaultStatus.error, errorMessage: e.toString());
    }
  }

  // ... other methods for add, update, delete, share ...
}
