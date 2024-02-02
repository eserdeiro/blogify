import 'package:blogify/config/index.dart';
import 'package:blogify/features/user/domain/index.dart';
import 'package:blogify/features/user/infrastructure/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepositoryImpl = UserRepositoryImpl();

  return UserNotifier(userRepositoryImpl: userRepositoryImpl);
});

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository userRepositoryImpl;

  UserNotifier({required this.userRepositoryImpl}) : super(UserState());

  Stream<Resource<UserEntity>> getUserById(String id) {
    state = state.copyWith(
      user: userRepositoryImpl.getUserById(id),
    );
    return userRepositoryImpl.getUserById(id);
  }

  Future<Resource<String>> getCurrentUserId() {
    state = state.copyWith(
      user: userRepositoryImpl.getCurrentUserId(),
    );
    return userRepositoryImpl.getCurrentUserId();
  }

  void setError(String errorMessage) {
    state = state.copyWith(
      user: Resource<String>(
        ResourceStatus.error,
        message: errorMessage,
      ),
    );
  }

  Future<Resource> edit(UserEntity user) async {
    final userEdit = await userRepositoryImpl.edit(user);
    state = state.copyWith(
      user: userEdit,
    );
    return userEdit;
  }

  Future<Resource> delete(String password) {
    state = state.copyWith(
      user: userRepositoryImpl.deleteUser(password),
    );
    return userRepositoryImpl.deleteUser(password);
  }
}

class UserState {
  final dynamic user;

  UserState({
    this.user,
  });

  UserState copyWith({
    dynamic user,
  }) =>
      UserState(
        user: user ?? this.user,
      );
}
