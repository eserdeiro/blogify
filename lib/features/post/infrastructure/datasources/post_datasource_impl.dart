import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostDataSourceImpl extends PostDataSource {
  @override
  @override
  Future<Resource<String>> publishPost(PostEntity post) async {
    try {
      final CollectionReference collection =
          FirebaseHelper.firebaseFirestore.collection('Posts');

      final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;

      final postImage = await FirebaseHelper.uploadImageAndReturnUrl(
        post.image,
        'Posts',
        userFirebaseAuth!.uid,
      );

      final postId = collection.doc().id;

      final postReference = collection.doc(postId);

      post
        ..userId = userFirebaseAuth.uid
        ..postId = postId
        ..image = postImage;

      // Guardar el post en la colección
      await postReference.set(
        post.toJson(),
      );

      return Resource<String>(ResourceStatus.success, data: 'data');
    } catch (e) {
      return Resource<String>(ResourceStatus.error, error: e.toString());
    }
  }

  @override
  Future<Resource<String>> deletePost(String postId) async {
    try {
      final CollectionReference collection =
          FirebaseHelper.firebaseFirestore.collection('Posts');

      final postReference = collection.doc(postId);

      await postReference.delete();
      print('Post deleted');
      return Resource<String>(ResourceStatus.success, data: 'post-deleted');
    } on FirebaseAuthException catch (e) {
      print('Error deleting');
      return Resource<String>(ResourceStatus.error, error: e.code);
    }
  }

  @override
  Future<Resource<List<PostEntity>>> getAllPosts() async {
    try {
      final querySnapshot =
          await FirebaseHelper.firebaseFirestore.collection('Posts').get();

      final allPosts = <PostEntity>[];

      for (final userSnapshot in querySnapshot.docs) {
        if (userSnapshot.exists) {
          final postMap = userSnapshot.data();
          final postEntity = PostEntity.fromJson(postMap);
          allPosts.add(postEntity);
        }
      }
      return Resource<List<PostEntity>>(ResourceStatus.success, data: allPosts);
    } on FirebaseException catch (e) {
      return Resource<List<PostEntity>>(ResourceStatus.error, error: e.code);
    }
  }

  @override
  Stream<Resource<List<PostEntity>>> getAllPostsByUser(String userId) {
    try {
      return FirebaseHelper.firebaseFirestore
          .collection('Posts')
          .snapshots()
          .map((querySnapshot) {
        final dataMap = querySnapshot.docs
            .where(
              (post) =>
                  post.data().containsKey('userId') && post['userId'] == userId,
            )
            .map(
              (post) => PostEntity.fromJson(post.data()),
            )
            .toList();

        return Resource<List<PostEntity>>(
          ResourceStatus.success,
          data: dataMap,
        );
      });
    } on FirebaseException catch (e) {
      return Stream.value(
        Resource<List<PostEntity>>(
          ResourceStatus.error,
          error: e.code,
        ),
      );
    } catch (e) {
      return Stream.value(
        Resource<List<PostEntity>>(
          ResourceStatus.error,
          error: e.toString(),
        ),
      );
    }
  }
}
