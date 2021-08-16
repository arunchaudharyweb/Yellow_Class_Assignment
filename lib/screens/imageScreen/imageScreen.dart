import 'package:flutter/material.dart';
import 'dart:io';
import '../../models/movieModel.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({@required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
          child: Hero(
              tag: movieModel.id,
              child: Image.file(
                File(movieModel.posterPath),
                fit: BoxFit.contain,
              ))),
    );
  }
}
