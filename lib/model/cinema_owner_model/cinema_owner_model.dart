class CinemaOwnerModel {
  String id;
  String name;
  String email;
  String phone;
  String photo;
  String gender;
  String cinemaID;
  bool online;
  bool ban;

  CinemaOwnerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.cinemaID,
    required this.online,
    required this.ban,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'photo': this.photo,
      'gender': this.gender,
      'cinemaID': this.cinemaID,
      'online': this.online,
      'ban': this.ban,
    };
  }

  factory CinemaOwnerModel.fromMap(Map<String, dynamic> map) {
    return CinemaOwnerModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      photo: map['photo'] as String,
      gender: map['gender'] as String,
      cinemaID: map['cinemaID']  ?? '',
      online: map['online'] as bool,
      ban: map['ban'] as bool,
    );
  }
}
