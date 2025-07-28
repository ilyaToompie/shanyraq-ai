import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shyraq_ai/features/users/data/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<LoadAllUsersFromRegion>(_onLoadAllUsersFromRegion);
    on<LoadUserById>(_onLoadUserById);
    on<UpsertUser>(_onUpsertUser);
    on<DeleteUser>(_onDeleteUser);
    on<LoadCurrentUser>(_onLoadCurrentUser);
  }

  Future<void> _onLoadCurrentUser(event, emit) async {
    emit(UsersLoading());
    try {
      final user = await repository.getCurrentUser();
      if (user == null) {
        emit(UserError('user not found'));
      } else {
        emit(UserLoaded(user));
      }
    } catch (e) {
      emit(UserError('Failed to load user: $e'));
    }
  }

  Future<void> _onLoadAllUsersFromRegion(
    LoadAllUsersFromRegion event,
    Emitter<UserState> emit,
  ) async {
    emit(UsersLoading());
    try {
      final users = await repository.getUsersByRegion(event.region);
      emit(UsersLoaded(users));
    } catch (_) {
      emit(UserError('Failed to load users from region'));
    }
  }

  Future<void> _onLoadUserById(
    LoadUserById event,
    Emitter<UserState> emit,
  ) async {
    emit(UsersLoading());
    try {
      final user = await repository.getUserById(event.userId);
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError("User not found"));
      }
    } catch (_) {
      emit(UserError('Failed to load user by ID'));
    }
  }

  Future<void> _onUpsertUser(UpsertUser event, Emitter<UserState> emit) async {
    try {
      await repository.upsertUser(event.userId, event.userData);
    } catch (_) {
      emit(UserError('Failed to upsert user'));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    try {
      await repository.deleteUser(event.userId);
    } catch (_) {
      emit(UserError('Failed to delete user'));
    }
  }
}
