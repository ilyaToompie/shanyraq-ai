abstract class UserEvent {}

class LoadAllUsersFromRegion extends UserEvent {
  final String region;
  LoadAllUsersFromRegion(this.region);
}

class LoadUserById extends UserEvent {
  final String userId;
  LoadUserById(this.userId);
}

class UpsertUser extends UserEvent {
  final String userId;
  final Map<String, dynamic> userData;
  UpsertUser({required this.userId, required this.userData});
}

class DeleteUser extends UserEvent {
  final String userId;
  DeleteUser(this.userId);
}
