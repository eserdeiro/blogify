import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/infrastructure/index.dart';
import 'package:blogify/features/user/domain/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepositoryImpl = AuthRepositoryImpl();

  return AuthNotifier(authRepositoryImpl: authRepositoryImpl);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepositoryImpl;

  AuthNotifier({required this.authRepositoryImpl}) : super(AuthState());

  Future<void> logout() async {
    return authRepositoryImpl.logout();
  }

  Future<Resource> checkAuthStatus() async {
    final user = await authRepositoryImpl.checkAuthStatus();
    state = state.copyWith(
      user: user,
    );
    return user;
  }

  Future<Resource> login(String email, String password) async {
    final user = await authRepositoryImpl.login(email, password);
    state = state.copyWith(
      user: user,
    );
    return user;
  }

  Future<Resource> register(
    UserEntity user,
  ) async {
    final userRegister = await authRepositoryImpl.register(
      user,
    );
    state = state.copyWith(
      user: userRegister,
    );
    return userRegister;
  }
}

class AuthState {
  final Resource? user;

  AuthState({
    this.user,
  });

  AuthState copyWith({
    Resource? user,
  }) =>
      AuthState(
        user: user ?? this.user,
      );
}
