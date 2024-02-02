import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/infrastructure/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).login;

  return LoginFormNotifier(
    loginUserCallback: loginUserCallback,
  );
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }) : super(LoginFormState());

  void onEmailChange(String value) {
    final email = Email.dirty(value.trim());
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([email]),
    );
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value.trim());
    state = state.copyWith(
      password: password,
      isValid: Formz.validate([password]),
    );
  }

  Future<void> onSubmit() async {
    validateEveryone();
    if (!state.isValid) return;
    await loginUserCallback(state.email.value, state.password.value);
  }

  void validateEveryone() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    );
  }
}

class LoginFormState {
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
      LoginFormState(
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
LoginFormState: 
  isFormPosted: $isFormPosted
  isValid: $isValid
  email: $email
  password: $password
''';
  }
}
