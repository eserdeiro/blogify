import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataSourceImpl extends PostDataSource {
  @override
  Future<Resource> publishPost(PostEntity post) async {
    //Add published post to user
    final CollectionReference collection =
        FirebaseHelper.firebaseFirestore.collection('Users');
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
    post.image = await FirebaseHelper.uploadImageAndReturnUrl(
      post.image,
      Strings.usersCollection,
      userFirebaseAuth!.uid,
    );

    await collection.doc(userFirebaseAuth.uid).update({
      'posts': FieldValue.arrayUnion([post.toJson()]),
    });

    print('''
Datasource: 
  title: ${post.title}
  description: ${post.description}
  image: ${post.image}
  edited: ${post.edited}
  createdAt: ${post.createdAt}
''');
    return Success('data');
  }

  // @override
  // Future<Resource<List<PostEntity>>> getAllPosts() async {
  //   try {
  //     final querySnapshot =
  //         await FirebaseHelper.firebaseFirestore.collection('Users').get();

  //     final allPosts = [];

  //     for (final userSnapshot in querySnapshot.docs) {
  //       if (userSnapshot.exists) {
  //         final List<dynamic>? postsJson = userSnapshot.data()['posts'];
  //         if (postsJson != null) {
  //           final userPosts = postsJson
  //               .map((postJson) => PostEntity.fromJson(postJson))
  //               .toList();

  //           allPosts.addAll(userPosts);
  //         }
  //       }
  //     }

  //     allPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  //     return Success(allPosts as List<PostEntity>);
  //   } catch (_) {
  //     return Error('');
  //   }
  // }
}
