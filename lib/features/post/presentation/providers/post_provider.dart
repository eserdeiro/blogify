import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:blogify/features/post/domain/repositories/post_repository.dart';
import 'package:blogify/features/post/infrastructure/repositories/post_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final postRepositoryImpl = PostRepositoryImpl();

  return PostNotifier(postRepositoryImpl: postRepositoryImpl);
});

class PostNotifier extends StateNotifier<PostState> {
  final PostRepository postRepositoryImpl;

  PostNotifier({required this.postRepositoryImpl}) : super(PostState());

  Future<void> publish(
    PostEntity post,
  ) async {
    final userRegister = await postRepositoryImpl.publish(
      post,
    );
    switch (userRegister) {
      case Loading _:
        state = state.copyWith(
          post: userRegister,
        );
      case Success _:
        state = state.copyWith(
          post: userRegister,
        );
      case Error _:
        state = state.copyWith(
          post: userRegister,
        );
    }
  }
}

class PostState {
  final Resource? post;

  PostState({
    this.post,
  });

  PostState copyWith({
    Resource? post,
  }) =>
      PostState(
        post: post ?? this.post,
      );
}
