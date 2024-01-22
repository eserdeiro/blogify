import 'package:blogify/features/infrastructure/index.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {
  LoginCubit() : super(const LoginFormState());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> onSubmit() async {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        password: Password.dirty(state.password.value),
        email: Email.dirty(state.email.value),
        isValid: Formz.validate([
          state.email,
          state.password,
        ]),
      ),
    );
    print('onSubmit $state');
    //TODO add try catch 'An error has occurred'
    if (state.isValid) {
      try {
        final data = await _firebaseAuth.signInWithEmailAndPassword(
          email: state.email.value,
          password: state.password.value,
        );
        print('firebase data ${data.credential}');
      } catch (e) {
        print('Firebase authentication error: $e');
        // Handle the error appropriately
      }
    }
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }
}
