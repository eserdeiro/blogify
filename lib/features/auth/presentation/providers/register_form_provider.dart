import 'package:blogify/config/helpers/formats.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/presentation/providers/auth_provider.dart';
import 'package:blogify/infrastructure/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(UserEntity) registerUserCallback;
  RegisterFormNotifier({
    required this.registerUserCallback,
  }) : super(RegisterFormState());

  void onNameChange(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      isValid: Formz.validate([
        name,
        state.email,
        state.password,
        state.lastname,
        state.username,
        state.gender,
      ]),
    );
  }

  void onLastnameChange(String value) {
    final lastname = Lastname.dirty(value);
    state = state.copyWith(
      lastname: lastname,
      isValid: Formz.validate([
        lastname,
        state.email,
        state.password,
        state.name,
        state.username,
        state.gender,
      ]),
    );
  }

  void onUsernameChange(String value) {
    final username = Username.dirty(value);
    state = state.copyWith(
      username: username,
      isValid: Formz.validate([
        username,
        state.lastname,
        state.email,
        state.password,
        state.name,
        state.gender,
      ]),
    );
  }

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([
        email,
        state.password,
        state.name,
        state.lastname,
        state.username,
        state.gender,
      ]),
    );
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      isValid: Formz.validate([
        password,
        state.email,
        state.name,
        state.lastname,
        state.username,
        state.gender,
      ]),
    );
  }

  void onGenderChange(GenderType value) {
    final gender = Gender.dirty(value);
    state = state.copyWith(
      gender: gender,
      isValid: Formz.validate([
        gender,
        state.username,
        state.lastname,
        state.email,
        state.password,
        state.name,
      ]),
    );
  }

  Future<void> onSubmit() async {
    validateEveryone();
    if (!state.isValid) return;
    print(state);
    //register firebase working
    await registerUserCallback(
        UserEntity(
        id: '', 
        email: state.email.value, 
        password: state.password.value, 
        name: state.name.value, 
        lastname: state.lastname.value, 
        username: state.username.value,),);
  }

  void validateEveryone() {
    final name = Name.dirty(state.name.value);
    final lastname = Lastname.dirty(state.lastname.value);
    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final gender = Gender.dirty(state.gender.value);

    state = state.copyWith(
      isFormPosted: true,
      isValid: Formz.validate([email, password]),
      name: name,
      lastname: lastname,
      username: username,
      email: email,
      password: password,
      gender: gender,
      
    );
  }
}

class RegisterFormState {
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Lastname lastname;
  final Username username;
  final Email email;
  final Password password;
  final Gender gender;

  RegisterFormState({
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.lastname = const Lastname.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.gender = const Gender.pure(),
  });

  RegisterFormState copyWith({
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Lastname? lastname,
    Username? username,
    Email? email,
    Password? password,
    Gender? gender,
  }) =>
      RegisterFormState(
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        gender: gender ?? this.gender,
      );

  @override
  String toString() {
    return '''
RegisterFormState: 

isFormPosted: $isFormPosted
isValid: $isValid
name: $name
lastname: $lastname
username: $username
email: $email
password: $password
gender: ${Formats.getGenderSelected(gender.value)}
''';
  }
}
