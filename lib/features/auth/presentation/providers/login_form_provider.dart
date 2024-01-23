import 'package:blogify/infrastructure/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  LoginFormNotifier() : super(LoginFormState());

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
    );
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.email]),
    );
  }

  Future<void> onSubmit() async {
    validateEveryone();
    if (!state.isValid) return;
       if (state.isValid) {
      try {
        final data = await _firebaseAuth.signInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        print('FIREBASE DATA $data');
      } catch (e) {
        print('Firebase authentication error: $e');
      }
    }
    print(state);

    //Firebase impl
     
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
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
LoginFormState: 

isPosting: $isPosting
isFormPosted: $isFormPosted
isValid: $isValid
email: $email
password: $password
''';
  }
}
