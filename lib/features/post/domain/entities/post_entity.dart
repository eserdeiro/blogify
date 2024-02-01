class PostEntity {
  String? userId;
  String? postId;
  String title;
  String description;
  bool edited;
  DateTime createdAt;
  String image;

  PostEntity({
    required this.title,
    required this.description,
    required this.edited,
    required this.createdAt,
    required this.image,
    this.userId,
    this.postId,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        userId: json['userId'] ?? '',
        postId: json['postId'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        edited: json['edited'] ?? false,
        createdAt: DateTime.parse(json['createdAt']),
        image: json['image'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'postId': postId,
        'title': title,
        'description': description,
        'edited': edited,
        'createdAt': createdAt.toIso8601String(),
        'image': image,
      };
}
