import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/repositories/user_repository.dart';
import 'package:blogify/features/auth/infrastructure/repositories/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepositoryImpl = UserRepositoryImpl();

  return UserNotifier(userRepositoryImpl: userRepositoryImpl);
});

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository userRepositoryImpl;

  UserNotifier({required this.userRepositoryImpl}) : super(UserState());

  // Future<void> registerUser(
  //   UserEntity user
  // ) async {
  //   final userRegister = await authRepositoryImpl.register(
  //     user,
  //   );

//     switch (userRegister) {
//       case Loading _:
//         state = state.copyWith(
//           user: userRegister,
//           authStatus: AuthStatus.checking,
//         );
//       case Success _:
//         state = state.copyWith(
//           user: userRegister,
//           authStatus: AuthStatus.authenticated,
//         );
//       case Error _:
//         state = state.copyWith(
//           user: userRegister,
//           authStatus: AuthStatus.notAuthenticated,
//         );
//     }
//   }
// }
}
enum UserStatus { checking, authenticated, notAuthenticated }

class UserState {
  final UserStatus authStatus;
  final Resource? user;

  UserState({
    this.authStatus = UserStatus.checking,
    this.user,
  });

  UserState copyWith({
    UserStatus? authStatus,
    Resource? user,
  }) =>
      UserState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
      );
}
