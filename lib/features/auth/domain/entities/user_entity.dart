import 'package:blogify/features/post/domain/entities/post_entity.dart';

class UserEntity {
  String id;
  String email;
  String password;
  String name;
  String lastname;
  String username;
  String image;
  List<PostEntity>? posts;

  UserEntity({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.lastname,
    required this.username,
    required this.image,
    this.posts,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        name: json['name'] ?? '',
        lastname: json['lastname'] ?? '',
        username: json['username'] ?? '',
        image: json['image'] ?? '',
        posts: json['posts'] == null
            ? []
            : List<PostEntity>.from(
                (json['posts'] as List<dynamic>).map(
                  (postJson) => PostEntity.fromJson(postJson),
                ),
              ),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'lastname': lastname,
        'username': username,
        'image': image,
        'posts':
            posts == null ? [] : List<PostEntity>.from(posts!.map((x) => x)),
      };
}
