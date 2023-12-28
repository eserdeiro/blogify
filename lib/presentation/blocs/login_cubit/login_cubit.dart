import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:blogify/infrastructure/inputs.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {
  LoginCubit() : super(const LoginFormState());

  //FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void onSubmit() async {
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      password: Password.dirty(state.password.value),
      email   : Email.dirty(state.email.value),
      isValid: Formz.validate([
        state.email,
        state.password
      ])
    ));
    // print('onSubmit $state');
    // if(state.isValid){
    // final data = await _firebaseAuth.signInWithEmailAndPassword(
    //     email: state.email.value, 
    //     password: state.password.value);
    //   print("firebase data $data");   
    // }
   
  }

  void  emailChanged(String value){
    final email = Email.dirty(value);
    emit(
     
      state.copyWith(
        email : email,
        isValid: Formz.validate([email, state.password]))
    );
  }

  
  void  passwordChanged(String value){
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]))
    );
  }
}

