enum UserType { particular, professional }

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.phone,
    this.type = UserType.particular,
    this.createdAt,
  });

  final String? id;
  final String name;
  final String email;
  final String phone;
  final String? password;
  final UserType type;
  final DateTime? createdAt;
}
