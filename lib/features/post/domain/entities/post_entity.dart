class PostEntity {
    String title;
    String description;
    bool edited;
    DateTime? createdAt;
    String image;
    
    PostEntity({
        required this.title,
        required this.description,
        required this.edited,
        required this.createdAt,
        required this.image,
    });

    factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        edited: json['edited'] ?? false,
         createdAt: json['createdAt'] != null
      ? DateTime.parse(json['createdAt'])
      : null,
        image: json['image'] ?? '',
    );

    Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'edited': edited,
        'createdAt': createdAt!.toIso8601String(),
        'image': image,
    };
}
