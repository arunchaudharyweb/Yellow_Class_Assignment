import 'package:flutter/material.dart';

class MovieModel {
  int id;
  String name;
  String directorName;
  String posterPath;

  MovieModel(
      {@required this.id,
      @required this.name,
      @required this.directorName,
      @required this.posterPath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'directorName': directorName,
      'posterPath': posterPath,
    };
  }
}
