part of 'register_cubit.dart';

  enum FormStatus {invalid, valid, validating, posting}

 class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Name     name;
  final LastName lastName;
  final Username userName;
  final Email    email;
  final Password password;
  final Gender   gender;

  const RegisterFormState({
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.name     = const Name.pure(), 
    this.lastName = const LastName.pure(),
    this.userName = const Username.pure(),
    this.email    = const Email.pure(), 
    this.password = const Password.pure(),
    this.gender   = const Gender.pure(),
   });

  RegisterFormState copyWith({
  bool?    isValid,
  FormStatus? formStatus,
  Name?     name,
  LastName? lastName,
  Username? userName,
  Email?    email,
  Password? password,
  Gender?   gender,
  }) => RegisterFormState(
    isValid: isValid ?? this.isValid,
    formStatus: formStatus ?? this.formStatus,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    userName: userName ?? this.userName,
    email: email ?? this.email,
    password: password ?? this.password,
    gender: gender ?? this.gender
  );


  @override
  List<Object> get props => [formStatus, name, lastName, userName,  email, password, gender];
}

