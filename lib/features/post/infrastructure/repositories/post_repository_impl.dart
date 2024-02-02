import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:blogify/features/post/domain/repositories/post_repository.dart';
import 'package:blogify/features/post/infrastructure/datasources/post_datasource_impl.dart';

class PostRepositoryImpl extends PostRepository {
  final PostDataSource datasource;

  PostRepositoryImpl({
    PostDataSource? datasource,
  }) : datasource = datasource ?? PostDataSourceImpl();

  @override
  Future<Resource<String>> publishPost(PostEntity post) {
    return datasource.publishPost(post);
  }
  
  @override
    Future<Resource<List<PostEntity>>> getAllPosts() {
    return datasource.getAllPosts();
  }
  
  @override
  Stream<Resource<List<PostEntity>>> getAllPostsByUser(String userId) {
    return datasource.getAllPostsByUser(userId);
  }
  
  @override
  Future<Resource> deletePost(String postId) {
    return datasource.deletePost(postId);
  }
}
