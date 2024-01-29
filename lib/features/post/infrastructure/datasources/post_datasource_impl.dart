import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/post/domain/datasources/post_datasource.dart';
import 'package:blogify/features/post/domain/entities/post_entity.dart';

class PostDataSourceImpl extends PostDataSource{
  @override
  Future<Resource> publish(PostEntity post) async{
    print('''
Datasource: 
  title: ${post.title}
  description: ${post.description}
  image: ${post.image}
  edited: ${post.edited}
  createdAt: ${post.createdAt}
''');
  return Error('data');
  }

}
