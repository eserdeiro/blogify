import 'package:blogify/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:blogify/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({
    super.key,
  });

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
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
               child: Text('Register',
                style: titleStyle.headlineMedium
                  ),
             ),
              const Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    label: 'Lastname',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ],
            ),

             const SizedBox(height: 16),
            
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
              prefixIcon: const Icon(Icons.lock),
             ),
             //Birthdate

             //Gender

             Padding(
               padding: const EdgeInsets.symmetric(vertical: 16),
               child: CustomElevatedButton(
                text: "Check in", 
                onPressed: () {
                loginCubit.onSubmit();
                print(email.value);
                print(password.value);
                }),
             ),


          ],
        ),
      ),
    );
  }
}