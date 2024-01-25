 
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/presentation/index.dart'; 
import 'package:blogify/infrastructure/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final userEditFormProvider =
    StateNotifierProvider.autoDispose<UserEditFormNotifier, UserEditFormState>(
        (ref) {
  final userEditCallback = ref.watch(userProvider.notifier).edit;
  return UserEditFormNotifier(userEditCallback: userEditCallback);
});

class UserEditFormNotifier extends StateNotifier<UserEditFormState> {
  final Function(UserEntity) userEditCallback;
  UserEditFormNotifier({
    required this.userEditCallback,
  }) : super(UserEditFormState());

  void onNameChange(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      isValid: Formz.validate([
        name,
        state.email,
        state.lastname,
        state.username,
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
        state.name,
        state.username,
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
        state.name,
      ]),
    );
  }

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([
        email,
        state.name,
        state.lastname,
        state.username,
      ]),
    );
  }

  Future<void> onSubmit() async {
    validateEveryone();
    if (!state.isValid) return;
    print('on submit state ${state.email} ${state.lastname} ${state.name} ${state.username}');
    await userEditCallback(
        UserEntity(
        id: '', 
        password: '',
        email: state.email.value, 
        name: state.name.value, 
        lastname: state.lastname.value, 
        username: state.username.value,),);
  }

  void validateEveryone() {
    final name = Name.dirty(state.name.value);
    final lastname = Lastname.dirty(state.lastname.value);
    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);

    state = state.copyWith(
      isFormPosted: true,
      isValid: Formz.validate([email, name, lastname, username, email]),
      name: name,
      lastname: lastname,
      username: username,
      email: email,
    );
  }
}

class UserEditFormState {
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Lastname lastname;
  final Username username;
  final Email email;

  UserEditFormState({
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.lastname = const Lastname.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
  });

  UserEditFormState copyWith({
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Lastname? lastname,
    Username? username,
    Email? email,
  }) =>
      UserEditFormState(
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        username: username ?? this.username,
        email: email ?? this.email,
      );

  @override
  String toString() {
    return '''
UserEditFormState: 

isFormPosted: ${isFormPosted}
isValid: $isValid
name: $name
lastname: $lastname
username: $username
email: $email
''';
  }
}
