import 'package:shyraq_ai/features/users/domain/user.dart';

abstract class IUserRepository {
  Stream<List<User>> getAllUsers();
  Future<User?> getUserById(String id);
  Future<List<User?>> getUsersByRegion(String region);

  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
