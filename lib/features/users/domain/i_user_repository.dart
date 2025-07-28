import 'package:shyraq_ai/features/users/domain/user.dart';

abstract class IUserRepository {
  Stream<List<AppUser>> getAllUsers();
  Future<AppUser?> getUserById(String id);
  Future<List<AppUser?>> getUsersByRegion(String region);

  Future<void> upsertUser(String userId, Map<String, dynamic> userData);
  Future<void> deleteUser(String id);
}
