import '../../models/vault.dart';

abstract class IVaultBackend {
  Future<List<Vault>> fetchVaults(String userId);
  Future<void> addVault(Vault vault);
  Future<void> updateVault(String id, Vault updatedVault);
  Future<void> deleteVault(String id);
  Future<void> shareVault(String id, List<String> userIds);
}
