class UserEntity {
    String id;
    String email;
    String name;
    String lastname;
    String username;

    UserEntity({
        required this.id,
        required this.email,
        required this.name,
        required this.lastname,
        required this.username,
    });

    factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        lastname: json['lastname'],
        username: json['username'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'lastname': lastname,
        'username': username,
    };
}
