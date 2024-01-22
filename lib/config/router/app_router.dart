import 'package:blogify/features/auth/presentation/screens/login_screen.dart';
import 'package:blogify/features/auth/presentation/screens/register_screen.dart';
import 'package:go_router/go_router.dart';


// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(),
    // ),
     GoRoute(
      path: '/',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
      GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),

  ],
);
