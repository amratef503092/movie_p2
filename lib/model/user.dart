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
  String cinemaID;
  String age;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.photo,
    required this.online,
    required this.ban,
    required this.phone,
    required this.cinemaID,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'role': this.role,
      'gender': this.gender,
      'photo': this.photo,
      'online': this.online,
      'ban': this.ban,
      'phone': this.phone,
      'cinemaID': this.cinemaID,
      'age': this.age,
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
      cinemaID: map['cinemaID'] as String,
      age: map['age'] as String,
    );
  }
}