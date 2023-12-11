import 'package:flutter/material.dart';
import 'package:blogify/presentation/widgets.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            
             const CustomTextFormField(
              label: 'Email',
              prefixIcon: Icon(Icons.mail_outlined),
             ),
      
             const SizedBox(height: 16),
      
             const CustomTextFormField(
              obscureText: true,
              label: 'Password',
              prefixIcon: Icon(Icons.lock),
             ),
      
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 16),
               child: CustomElevatedButton(
                text: "Les't go", 
                onPressed: () {}),
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