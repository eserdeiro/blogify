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

  Future<Resource> publish(
    PostEntity post,
  ) async {
    final publishPost = await postRepositoryImpl.publishPost(
      post,
    );
    state = state.copyWith(
      post: publishPost,
    );
    return publishPost;
  }

  Future<Resource> deletePost(
    String postId,
  ) async {
    final postToDelete = await postRepositoryImpl.deletePost(
      postId,
    );
    state = state.copyWith(
      post: postToDelete,
    );
    return postToDelete;
  }

  Future<Resource<List<PostEntity>>> getAllPosts() async {
    final allPosts = await postRepositoryImpl.getAllPosts();
    state = state.copyWith(
      post: allPosts,
    );
    return allPosts;
  }

  Stream<Resource<List<PostEntity>>> getAllPostsByUserId(
    String userId,
  ) {
    final allPosts = postRepositoryImpl.getAllPostsByUser(userId);
    state = state.copyWith(
      post: allPosts,
    );
    return allPosts;
  }
}

class PostState {
  final dynamic post;

  PostState({
    this.post,
  });

  PostState copyWith({
    dynamic post,
  }) =>
      PostState(
        post: post ?? this.post,
      );
}
