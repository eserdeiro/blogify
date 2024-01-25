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
}

enum UserStatus { checking, authenticated, notAuthenticated }

class UserState {
  final UserStatus authStatus;
  final dynamic user;

  UserState({
    this.authStatus = UserStatus.checking,
    this.user,
  });

  UserState copyWith({
    UserStatus? authStatus,
    dynamic user,
  }) =>
      UserState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
      );
}
