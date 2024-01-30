import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/infrastructure/index.dart';
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

    Stream<Resource<UserEntity>> getCurrentUser() {
    state = state.copyWith(
      user: userRepositoryImpl.getCurrentUSer(),
    );
    return userRepositoryImpl.getCurrentUSer();
  }

   void setError(String errorMessage) {
    state = state.copyWith(
      user: Error(errorMessage),
    );
  }

  Future<void> edit(UserEntity user) async {
    final userEdit = await userRepositoryImpl.edit(user);
    switch (userEdit) {
      case Loading _:
        state = state.copyWith(
          user: userEdit,
          userStatus: UserStatus.checking,
        );
      case Success _:
        state = state.copyWith(
          user: userEdit,
          userStatus: UserStatus.authenticated,
        );
      case Error _:
        state = state.copyWith(
          user: userEdit,
          userStatus: UserStatus.notAuthenticated,
        );
    }
  }
}

enum UserStatus { checking, authenticated, notAuthenticated }

class UserState {
  final UserStatus userStatus;
  final dynamic user;

  UserState({
    this.userStatus = UserStatus.checking,
    this.user,
  });

  UserState copyWith({
    UserStatus? userStatus,
    dynamic user,
  }) =>
      UserState(
        userStatus: userStatus ?? this.userStatus,
        user: user ?? this.user,
      );
}
