import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'components/floatingButton.dart';
import 'components/homePageBody.dart';
import '../../services/movieDataBloc.dart';
import '../../models/movieModel.dart';
import 'components/emptyHomePage.dart';
import '../userInfo/userInfoScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.title, @required this.user});

  final String title;
  final User user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MovieBloc movieBloc = MovieBloc();

  @override
  void dispose() {
    movieBloc.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfoScreen(
                          user: widget.user,
                          disposeBloc: () {
                            movieBloc.isDisposed = true;
                          }))))
        ],
      ),
      body: StreamBuilder<List<MovieModel>>(
          stream: movieBloc.movies,
          builder:
              (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length != 0
                  ? HomePageBody(
                      movies: snapshot.data,
                      deleteMovie: (int id) => movieBloc.deleteMovie(id),
                      editMovie: (MovieModel movieModel) =>
                          movieBloc.editMovie(movieModel))
                  : EmptyHomeScreen();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingButton(
        addMovie: (MovieModel movieModel) => movieBloc.addMovie(movieModel),
      ),
    );
  }
}
