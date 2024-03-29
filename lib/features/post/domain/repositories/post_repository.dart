import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<Resource<String>> publishPost(
    PostEntity post,
  );

  Future<Resource> deletePost(String postId);

  Future<Resource<List<PostEntity>>> getAllPosts();

  Stream<Resource<List<PostEntity>>> getAllPostsByUser(String userId);
}
