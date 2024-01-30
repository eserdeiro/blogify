class PostEntity {
  String? userId;
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
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        userId: json['userId'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        edited: json['edited'] ?? false,
        createdAt: DateTime.parse(json['createdAt']),
        image: json['image'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'description': description,
        'edited': edited,
        'createdAt': createdAt.toIso8601String(),
        'image': image,
      };
}
