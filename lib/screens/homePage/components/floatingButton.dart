import 'package:flutter/material.dart';

import '../../addAndEditMovie/addAndEditMovie.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({@required this.addMovie});
  final Function addMovie;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: Text('Movie'),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddOrEditMovie(
                      movieIsAdded: true,
                      title: 'Add Movie',
                      addMovieFunc: addMovie,
                    )));
      },
    );
  }
}
