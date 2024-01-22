import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/features/auth/presentation/index.dart';
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
      path: Strings.registerUrl,
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
    ),

  ],
);
