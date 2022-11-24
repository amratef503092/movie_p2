class MovieModel
{
  String description;
  bool expire;
  String hall;
  String id;
  String image;
  String nameMovie;
  String time;
  String cinemaID;

  MovieModel({
    required this.description,
    required this.expire,
    required this.hall,
    required this.id,
    required this.image,
    required this.nameMovie,
    required this.time,
    required this.cinemaID,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': this.description,
      'expire': this.expire,
      'hall': this.hall,
      'id': this.id,
      'image': this.image,
      'nameMovie': this.nameMovie,
      'time': this.time,
      'cinemaID': this.cinemaID,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      description: map['description'] as String,
      expire: map['expire'] as bool,
      hall: map['hall'] as String,
      id: map['id'] as String,
      image: map['image'] as String,
      nameMovie: map['nameMovie'] as String,
      time: map['time'] as String,
      cinemaID: map['cinemaID'] as String,
    );
  }
}