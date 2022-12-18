class UserModel {
  String image;
  String name;
  String email;
  String phone;

  UserModel({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
  }) =>
      UserModel(
        image: imagePath ?? image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  static UserModel fromJson(Map<String, dynamic>? json) => UserModel(
    image: json?['imagePath'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
    name: json?['name'] ?? '',
    email: json?['email'] ?? '',
    phone: json?['phone']?? '',
  );

  Map<String, dynamic> toJson() => {
    'imagePath': image,
    'name': name,
    'email': email,
    'phone': phone,
  };

  static UserModel myUser = UserModel(
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      name: '',
      email: '',
      phone: '',
  );
}