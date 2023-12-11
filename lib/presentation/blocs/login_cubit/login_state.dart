part of 'login_cubit.dart';

  enum FormStatus {invalid, valid, validating, posting}

 class LoginFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Email email;
  final Password password;

  const LoginFormState({
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
   this.email = const Email.pure(), 
   this.password = const Password.pure(),
   });

  LoginFormState copyWith({
  bool? isValid,
  FormStatus? formStatus,
  Email? email,
  Password? password,
  }) => LoginFormState(
    isValid: isValid ?? this.isValid,
    formStatus: formStatus ?? this.formStatus,
    email: email ?? this.email,
    password: password ?? this.password 
  );


  @override
  List<Object> get props => [formStatus, email, password];
}

