
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogify/config/helpers/formats.dart';
import 'package:blogify/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:blogify/presentation/widgets.dart';

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
    final registerCubit = context.watch<RegisterCubit>();
    final name = registerCubit.state.name;
    final lastName = registerCubit.state.lastName;
    final userName = registerCubit.state.userName;
    final email    = registerCubit.state.email;
    final password = registerCubit.state.password;
    final gender   = registerCubit.state.gender;
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
              Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'Name',
                    onChanged: registerCubit.nameChanged,
                    errorText: name.errorMessage,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: CustomTextFormField(
                    label: 'Lastname',
                    onChanged: registerCubit.lastNameChanged,
                    errorText: lastName.errorMessage,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

            CustomTextFormField(
              label: 'Username',
              onChanged: registerCubit.userNameChanged,
              errorText: userName.errorMessage,
              prefixIcon: const Icon(Icons.mail_outlined),
             ),

             const SizedBox(height: 16),
            
            CustomTextFormField(
              label: 'Email',
              onChanged: registerCubit.emailChanged,
              errorText: email.errorMessage,
              prefixIcon: const Icon(Icons.mail_outlined),
             ),
      
             const SizedBox(height: 16),
      
            CustomTextFormField(
              obscureText: true,
              onChanged: registerCubit.passwordChanged,
              errorText: password.errorMessage,
              label: 'Password',
              prefixIcon: const Icon(Icons.lock),
             ),

            const SizedBox(height: 16),

            CustomExpansionTile(
              onChanged: registerCubit.genderChanged,
              errorText: gender.errorMessage,
            ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 16),
               child: CustomElevatedButton(
                text: "Check in", 
                onPressed: () {
                registerCubit.onSubmit();
                print(name.value);
                print(lastName.value);
                print(userName.value);
                print(email.value);
                print(password.value);
                print(Formats.getGenderSelected(gender.value));
                }),
             ),

          ],
        ),
      ),
    );
  }
}