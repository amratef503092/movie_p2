class UserModel{
  String id;
  String name;
  String email;
  String role;
  String gender;
  String photo;
  bool online;
  bool ban;
  String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.photo,
    required this.online,
    required this.ban,
    required this.phone
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'phone' : this.phone,
      'role': this.role,
      'gender': this.gender,
      'photo': this.photo,
      'online': this.online,
      'ban': this.ban,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      role: map['role'] as String,
      gender: map['gender'] as String,
      photo: map['photo'] as String,
      online: map['online'] as bool,
      ban: map['ban'] as bool,
      phone: map['phone'] as String,
    );
  }
}