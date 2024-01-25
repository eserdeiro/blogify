import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: Strings.loginUrl,
  routes: [
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
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (_, state) {
        //The url is not a correct index? we redirect to ErrorScreen
        final page = state.pathParameters['page'] ?? '0';
        try {
          final pageIndex = int.parse(page);
          return (pageIndex < appMenuItems.length)
              ? HomeScreen(page: pageIndex)
              : const ErrorScreen();
        } catch (e) {
          return const ErrorScreen();
        }
      },
    ),
  ],
);
