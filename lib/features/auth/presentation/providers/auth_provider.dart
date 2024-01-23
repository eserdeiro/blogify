import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());
  Future<void> loginUser(String email, String password) async {
    final user = await authRepository.login(email, password);

    if (user is Success) {
      state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
      print('Inicio de sesión correcto');
    } else if (user is Error) {
      state =
          state.copyWith(user: user, authStatus: AuthStatus.notAuthenticated);
      print('Error in login: ${user.getErrorMessage()}');
    }
  }

  Future<void> registerUser(String email, String password) async {}

  Future<void> checkAuthStatus() async {}
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Resource? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    Resource? user,
    String errorMessage = '',
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage:
            errorMessage.isNotEmpty ? errorMessage : this.errorMessage,
      );
}
