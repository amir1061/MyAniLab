class User {
  late String username;
  // late String email;
  // late String image;

  User({
    required this.username,
    // required this.email,
    // required this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['name'];
    // email = json['email'];
    // image = json['image'];
  }
}
