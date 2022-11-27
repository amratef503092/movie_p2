class MiniShopsModel{
  String id;
  String name;
  String photo;
  String cinemaID;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'photo': this.photo,
      'cinemaID': this.cinemaID,
    };
  }

  factory MiniShopsModel.fromMap(Map<String, dynamic> map) {
    return MiniShopsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      photo: map['photo'] as String,
      cinemaID: map['cinemaId'] as String,
    );
  }

  MiniShopsModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.cinemaID,
  });
}