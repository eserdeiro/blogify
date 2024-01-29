import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataSourceImpl extends PostDataSource {
  @override
  Future<Resource> publish(PostEntity post) async {
    final CollectionReference collection =
        FirebaseHelper.firebaseFirestore.collection('Posts');
    post.image =
        await FirebaseHelper.uploadImageAndReturnUrl(post.image, 'Posts');
    await collection.doc('test').set(
          post.toJson(),
        );
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
