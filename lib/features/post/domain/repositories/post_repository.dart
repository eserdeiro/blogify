import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';

abstract class PostRepository {

  Future<Resource> publishPost( PostEntity post,);

 // Future<Resource<List<PostEntity>>> getAllPosts();
}
