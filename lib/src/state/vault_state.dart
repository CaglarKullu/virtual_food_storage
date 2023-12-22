import 'package:flutter/foundation.dart';
import '../models/vault.dart';

enum VaultStatus { initial, loading, success, error }

@immutable
class VaultState {
  final VaultStatus status;
  final List<Vault> vaults;
  final String? errorMessage;

  const VaultState({
    this.status = VaultStatus.initial,
    this.vaults = const [],
    this.errorMessage,
  });

  VaultState copyWith({
    VaultStatus? status,
    List<Vault>? vaults,
    String? errorMessage,
  }) {
    return VaultState(
      status: status ?? this.status,
      vaults: vaults ?? this.vaults,
      errorMessage: errorMessage,
    );
  }
}
