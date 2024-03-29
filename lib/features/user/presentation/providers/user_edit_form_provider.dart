import 'package:blogify/features/user/domain/index.dart';
import 'package:blogify/features/user/presentation/index.dart';
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

  void onImageChange(String path) {
    state = state.copyWith(
      image : path,
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
    final username = Username.dirty(value.trim());
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
    final email = Email.dirty(value.trim());
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

  Future<void> onSubmit(
    String initialName,
    String initialLastname,
    String initialUsername,
    String initialEmail,
    String initImage,
  ) async {
    validateEveryone(
      initialName,
      initialLastname,
      initialUsername,
      initialEmail,
      initImage,
    );

    if (!state.isValid) return;
    await userEditCallback(
      UserEntity(
        id: '',
        password: '',
        email: state.email.value,
        name: state.name.value,
        lastname: state.lastname.value,
        username: state.username.value,
        image: state.image,
      ),
    );
  }

  void validateEveryone(
    String initialName,
    String initialLastname,
    String initialUsername,
    String initialEmail,
    String initialImage,
  ) {
    final name = state.name.value.isEmpty
        ? Name.dirty(initialName)
        : Name.dirty(state.name.value);
    final lastname = state.lastname.value.isEmpty
        ? Lastname.dirty(initialLastname)
        : Lastname.dirty(state.lastname.value);
    final username = state.username.value.isEmpty
        ? Username.dirty(initialUsername)
        : Username.dirty(state.username.value);
    final email = state.email.value.isEmpty
        ? Email.dirty(initialEmail)
        : Email.dirty(state.email.value);
    final image = state.image.isEmpty ? 
    initialImage : state.image;

    state = state.copyWith(
      isFormPosted: true,
      isValid: Formz.validate([email, name, lastname, username]),
      name: name,
      lastname: lastname,
      username: username,
      email: email,
      image: image,
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
  final String image;

  UserEditFormState({
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.lastname = const Lastname.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.image = '',
  });

  UserEditFormState copyWith({
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Lastname? lastname,
    Username? username,
    Email? email,
    String? image,
  }) =>
      UserEditFormState(
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        username: username ?? this.username,
        email: email ?? this.email,
        image: image?? this.image,
      );

  @override
  String toString() {
    return '''
UserEditFormState: 

isFormPosted: $isFormPosted
isValid: $isValid
name: $name
lastname: $lastname
username: $username
email: $email
image: $image
''';
  }
}
