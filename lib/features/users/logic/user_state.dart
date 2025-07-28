import 'package:shyraq_ai/features/users/domain/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<AppUser> users;
  UsersLoaded(this.users);
}

class UserLoaded extends UserState {
  final AppUser user;
  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
