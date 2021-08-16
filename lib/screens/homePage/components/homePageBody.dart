import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_class_assignment/constants/constant.dart';
import 'dart:io';

import '../../addAndEditMovie/addAndEditMovie.dart';
import '../../../models/movieModel.dart';
import '../../imageScreen/imageScreen.dart';

class HomePageBody extends StatelessWidget {
  HomePageBody(
      {@required this.movies,
      @required this.deleteMovie,
      @required this.editMovie});
  final List<MovieModel> movies;
  final void Function(int) deleteMovie;
  final void Function(MovieModel) editMovie;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          MovieModel movieModel = movies[index];
          return Container(
            padding: EdgeInsets.all(16),
            height: 164,
            child: Column(
              children: [
                Card(
                  child: Container(
                    height: 132,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ImageScreen(movieModel: movieModel))),
                              child: Hero(
                                tag: movieModel.id,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(movieModel.posterPath),
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movieModel.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xffBCA961)),
                                          ),
                                          SizedBox(
                                            height: 12.0,
                                          ),
                                          Text(
                                            'Director | ${movieModel.directorName}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: kTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddOrEditMovie(
                                                    title: 'Edit Movie',
                                                    movieIsAdded: false,
                                                    movieData: movieModel,
                                                    editMovieFunc: editMovie,
                                                  )))),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => deleteMovie(movieModel.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
