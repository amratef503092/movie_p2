class HallsModel{
  String name;
  String description;
  String cinemaID;
  num seats;

  HallsModel({
    required this.name,
    required this.description,
    required this.cinemaID,
    required this.seats,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'description': this.description,
      'cinemaID': this.cinemaID,
      'seats': this.seats,
    };
  }

  factory HallsModel.fromMap(Map<String, dynamic> map) {
    return HallsModel(
      name: map['name'] as String,
      description: map['description'] as String,
      cinemaID: map['cinema_id'] as String,
      seats: map['seats'] as num,
    );
  }
}