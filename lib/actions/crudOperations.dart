import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/movieModel.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'MoviesDB.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE movies ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "directorName TEXT,"
        "posterPath TEXT"
        ")",
      );
    });
  }

  Future<void> createMovie(MovieModel movie) async {
    final Database db = await database;

    var res = await db.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Movie is $res');
  }

  Future<List<MovieModel>> readMovies() async {
    // Query the table for all The movies.
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('movies', orderBy: 'id DESC');
    // Convert the List<Map<String, dynamic> into a List<MovieModel>.
    return List.generate(maps.length, (i) {
      return MovieModel(
          id: maps[i]['id'],
          name: maps[i]['name'],
          directorName: maps[i]['directorName'],
          posterPath: maps[i]['posterPath']);
    });
  }

  Future<void> updateMovies(MovieModel movieModel) async {
    final Database db = await database;

    // Update the movie.
    var res = await db.update("movies", movieModel.toMap(),
        where: "id = ?", whereArgs: [movieModel.id]);
    print('updated movie $res');
  }

  Future<void> deleteMovies(int id) async {
    final Database db = await database;

    // Remove the movie from the Database.
    var res = await db.delete(
      'movies',
      // Use a `where` clause to delete a specific movie.
      where: "id = ?",
      // Pass the movie's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    print('rows affected $res');
  }
}
