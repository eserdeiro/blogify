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
    final publishPost = await postRepositoryImpl.publishPost(
      post,
    );
    switch (publishPost) {
      case Loading _:
        state = state.copyWith(
          post: publishPost,
        );
      case Success _:
        state = state.copyWith(
          post: publishPost,
        );
      case Error _:
        state = state.copyWith(
          post: publishPost,
        );
    }
  }

   Future<void> getAllPosts(
  ) async {
    final allPosts = await postRepositoryImpl.getAllPosts(
    );
    switch (allPosts) {
      case Loading _:
        state = state.copyWith(
          post: allPosts,
        );
      case Success _:
        state = state.copyWith(
          post: allPosts,
        );
      case Error _:
        state = state.copyWith(
          post: allPosts,
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
