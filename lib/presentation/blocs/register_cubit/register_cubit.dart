import 'package:blogify/infrastructure/inputs/lastname.dart';
import 'package:blogify/infrastructure/inputs/name.dart';
import 'package:blogify/infrastructure/inputs/username.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:blogify/infrastructure/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit(){
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      name : Name.dirty(state.name.value),
      lastName : LastName.dirty(state.lastName.value),
      userName : Username.dirty(state.userName.value),
      email    : Email.dirty(state.email.value),
      password : Password.dirty(state.password.value),
      isValid  : Formz.validate([
        state.name,
        state.lastName,
        state.userName,
        state.email,
        state.password
      ])
    ));
    print('onSubmit $state');
  }

  void  nameChanged(String value){
    final name = Name.dirty(value);
    emit(
     
      state.copyWith(
        name : name,
        isValid: Formz.validate([name, state.lastName, state.userName, state.email, state.password]))
    );
  }

   void  lastNameChanged(String value){
    final lastName = LastName.dirty(value);
    emit(
      state.copyWith(
        lastName : lastName,
        isValid: Formz.validate([lastName, state.name, state.userName, state.email, state.password]))
    );
  }

  void  userNameChanged(String value){
    final userName = Username.dirty(value);
    emit(
      state.copyWith(
        userName : userName,
        isValid: Formz.validate([userName, state.lastName, state.name, state.email, state.password]))
    );
  }

  void  emailChanged(String value){
    final email = Email.dirty(value);
    emit(
     
      state.copyWith(
        email : email,
        isValid: Formz.validate([email,state.lastName, state.name, state.userName, state.password]))
    );
  }

  
  void  passwordChanged(String value){
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email, state.name, state.lastName, state.userName]))
    );
  }
}

