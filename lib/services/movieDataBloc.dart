import 'dart:async';

import '../models/movieModel.dart';
import '../actions/crudOperations.dart';

class MovieBloc {
  MovieBloc() {
    listMovies();
  }
  bool isDisposed = false;

  final _moviesController = StreamController<List<MovieModel>>.broadcast();

  get movies => _moviesController.stream;

  Future disposeController() async {
    await _moviesController?.close();
  }

  listMovies() async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    if (isDisposed) {
      return;
    }

    if (!_moviesController.isClosed) {
      _moviesController.sink.add(await DBProvider.db.readMovies());
    }
    listMovies();
  }

  deleteMovie(int id) async {
    await DBProvider.db.deleteMovies(id);
    listMovies();
  }

  addMovie(MovieModel movie) async {
    await DBProvider.db.createMovie(movie);
    listMovies();
  }

  editMovie(MovieModel movieModel) async {
    await DBProvider.db.updateMovies(movieModel);
    listMovies();
  }
}
