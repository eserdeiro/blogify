import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/presentation/screens.dart';
import 'package:blogify/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';


// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Strings.loginUrl,
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(),
    // ),
     GoRoute(
      path: Strings.loginUrl,
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
      GoRoute(
      path: Strings.registerUrl,
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),
      GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),

  ],
);
