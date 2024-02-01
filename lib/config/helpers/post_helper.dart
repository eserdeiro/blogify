import 'package:blogify/features/post/domain/entities/post_entity.dart';

class PostHelper{
  static List<PostEntity> sortByRecentness(List<PostEntity> posts) {
  posts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  return posts;
}

  static bool isPostCreatedByUser(String postUserID, String currentUserID) {
 return postUserID == currentUserID;
}

}
