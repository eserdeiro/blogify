import 'package:blogify/presentation/widgets.dart';
import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        final titleStyle = Theme.of(context).textTheme;
        final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 16),
             child: Text('Login',
              style: titleStyle.headlineMedium
                ),
           ),
          
           const CustomTextFormField(
            label: 'Email',
            prefixIcon: Icon(Icons.mail_outlined),
           ),

           const SizedBox(height: 16),

           const CustomTextFormField(
            label: 'Password',
            prefixIcon: Icon(Icons.lock),
           ),
      
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 16),
             child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {
                //Not implemented
              },
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                )
              ),
               child: const Text("Let's go"),),
             ),
           ),
           const Padding(
             padding: EdgeInsets.only(bottom: 20),
             child: Center(child: Text('Dont have account? Sign up')),
           )
        ],
      ),
    );
  }
}