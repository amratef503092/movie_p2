import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:flutter/material.dart';

class ReleasedMovie extends Movie {
  int? id;
  bool? deleted;

  ReleasedMovie(
      {required this.id,
      required this.deleted,
      required super.name,
      required super.image,
      required super.rating,
      required super.duration,
      required super.overview,
      required super.genres,
      required super.adult});

  ReleasedMovie.fromJson(Map<String, dynamic> json)
      : super(
            adult: json["adult"],
            duration: json["duration"],
            genres: json["genres"],
            image: NetworkImage(json["imageUrl"]),
            name: json["name"],
            overview: json["overview"],
            rating: json["rating"]) {
    id = json["id"];
    deleted = json["deleted"];
  }
}
