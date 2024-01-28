class PostEntity {
    String id;
    String title;
    String description;
    bool edited;
    DateTime createdAt;
    String image;

    PostEntity({
        required this.id,
        required this.title,
        required this.description,
        required this.edited,
        required this.createdAt,
        required this.image,
    });

    factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        edited: json['edited'] ?? false,
        createdAt: json['createdAt'] ?? '',
        image: json['image'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'edited': edited,
        'createdAt': createdAt.toIso8601String(),
        'image': image,
    };
}
