import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataSourceImpl extends PostDataSource {
  @override
  Future<Resource> publish(PostEntity post) async {
    //Add published post to user
    final CollectionReference collection =
        FirebaseHelper.firebaseFirestore.collection('Users');
    final userFirebaseAuth = FirebaseHelper.firebaseAuth.currentUser;
    post.image = await FirebaseHelper.uploadImageAndReturnUrl(
        post.image, Strings.usersCollection, userFirebaseAuth!.uid);

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
}
