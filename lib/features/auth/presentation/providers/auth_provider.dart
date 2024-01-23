import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepositoryImpl = AuthRepositoryImpl();

  return AuthNotifier(authRepositoryImpl: authRepositoryImpl);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepositoryImpl;

  AuthNotifier({required this.authRepositoryImpl}) : super(AuthState());
  Future<void> loginUser(String email, String password) async {
    final user = await authRepositoryImpl.login(email, password);
    
    switch (user) {
      case Loading _:
        state = state.copyWith(
          user: user,
          authStatus: AuthStatus.checking,
        );
      case Success _:
        state = state.copyWith(
          user: user,
          authStatus: AuthStatus.authenticated,
        );
      case Error _:
        state = state.copyWith(
          user: user,
          authStatus: AuthStatus.notAuthenticated,
        );
    }
  }

  Future<void> registerUser(String email, String password) async {}

  Future<void> checkAuthStatus() async {}
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Resource? user;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    Resource? user,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
      );
}
