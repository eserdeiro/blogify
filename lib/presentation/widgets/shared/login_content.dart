import 'package:blogify/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:blogify/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({
    super.key,
  });

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
     final loginCubit = context.watch<LoginCubit>();
    final password = loginCubit.state.password;
    final email = loginCubit.state.email;

        final titleStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 16),
               child: Text('Login',
                style: titleStyle.headlineMedium
                  ),
             ),
            
            CustomTextFormField(
              label: 'Email',
              onChanged: loginCubit.emailChanged,
              errorText: email.errorMessage,
              prefixIcon: const Icon(Icons.mail_outlined),
             ),
      
             const SizedBox(height: 16),
      
            CustomTextFormField(
              obscureText: true,
              onChanged: loginCubit.passwordChanged,
              errorText: password.errorMessage,
              label: 'Password',
              prefixIcon: Icon(Icons.lock),
             ),
             
      
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 16),
               child: CustomElevatedButton(
                text: "Les't go", 
                onPressed: () {
                loginCubit.onSubmit();
                print(email.value);
                print(password.value);
                }),
             ),
             const Padding(
               padding: EdgeInsets.only(bottom: 20),
               child: Center(child: Text('Dont have account? Sign up')),
             )
          ],
        ),
      ),
    );
  }
}