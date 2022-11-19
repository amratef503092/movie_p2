import 'package:flutter/material.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';

class UpComingMovie extends Movie {
  String? trailer;

  UpComingMovie(
      {required this.trailer,
      required super.name,
      required super.image,
      required super.rating,
      required super.duration,
      required super.overview,
      required super.genres,
      required super.adult});

  UpComingMovie.fromJson(Map<String, dynamic> json)
      : super(
            adult: json["adult"],
            duration: json["duration"],
            genres: json["genre"],
            image: NetworkImage(json["imageUrl"]),
            name: json["name"],
            overview: json["overview"],
            rating: json["rating"]) {
    trailer = json["trailer"];
  }
}
