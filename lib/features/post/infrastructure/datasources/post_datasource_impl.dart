import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:blogify/presentation/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataSourceImpl extends PostDataSource {
  @override
  Future<Resource> publishPost(PostEntity post) async {
    //Publish post into Posts/postid/ postdata:

    final CollectionReference collection =
        FirebaseHelper.firebaseFirestore.collection('Posts');
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;

    final postId = collection.doc().id;

    final postReference = collection.doc(postId);
    post.userId = userFirebaseAuth!.uid;
    await postReference.set(
      post.toJson(),
    );
    return Success('data');
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
      //Sort by most recent
      // allPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Success(allPosts);
    } on FirebaseException catch (e) {
      return Error(e.code);
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
        print('post 0 ${dataMap[0].title}');
        return Success(dataMap);
      });
    } on FirebaseException catch (e) {
      return Stream.value(Error(e.code));
    } catch (e) {
      return Stream.value(Error(e.toString()));
    }
  }
}
