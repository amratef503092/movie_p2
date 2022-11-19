import 'package:flutter/cupertino.dart';

class Movie {
  String? name;
  NetworkImage? image;
  num? rating;
  int? duration;
  String? overview;
  String? genres;
  bool? adult;
  
  Movie({
    required this.name,
    required this.image,
    required this.rating,
    required this.duration,
    required this.overview,
    required this.genres,
    required this.adult,
  });
}
