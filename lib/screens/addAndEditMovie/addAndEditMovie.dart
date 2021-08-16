import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../models/movieModel.dart';
import '../../constants/constant.dart';

class AddOrEditMovie extends StatefulWidget {
  AddOrEditMovie(
      {@required this.movieIsAdded,
      this.movieData,
      @required this.title,
      this.addMovieFunc,
      this.editMovieFunc});
  final bool movieIsAdded;
  final MovieModel movieData;
  final String title;
  final void Function(MovieModel) addMovieFunc;
  final void Function(MovieModel) editMovieFunc;

  @override
  _AddOrEditMovieState createState() => _AddOrEditMovieState();
}

class _AddOrEditMovieState extends State<AddOrEditMovie> {
  final _textController = TextEditingController();

  String posterPath = '';
  String movieName = '';
  String directorName = '';
  int id = DateTime.now().microsecondsSinceEpoch;

  final _formKey = GlobalKey<FormState>();
  bool fileIsPicked = false;

  final ImagePicker _picker = ImagePicker();
  XFile _imageFile;

  String validator(String name) {
    if (name.isEmpty) return 'This field can\'t be empty';
    return null;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.movieData != null) {
      id = widget.movieData.id;
      movieName = widget.movieData.name;
      directorName = widget.movieData.directorName;
      posterPath = widget.movieData.posterPath;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  if (posterPath.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please also select a movie poster.'),
                    ));
                  } else {
                    if (widget.movieIsAdded) {
                      widget.addMovieFunc(MovieModel(
                          id: id,
                          name: movieName,
                          directorName: directorName,
                          posterPath: posterPath));
                      Navigator.pop(context);
                    } else {
                      widget.editMovieFunc(MovieModel(
                          id: id,
                          name: movieName,
                          directorName: directorName,
                          posterPath: posterPath));
                      Navigator.pop(context);
                    }
                  }
                } else {
                  print('error');
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: kIconColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            bottomRight: Radius.circular(8),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            _imageFile = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (_imageFile != null) {
                              print(_imageFile.path);
                              setState(() {
                                fileIsPicked = true;
                                posterPath = _imageFile.path;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  height: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: kIconColor, width: .5),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: widget.movieIsAdded && !fileIsPicked
                            ? AssetImage(
                                'assetImages/defaultImage.png',
                              )
                            : FileImage(File(posterPath)),
                        fit: widget.movieIsAdded && !fileIsPicked
                            ? BoxFit.fitWidth
                            : BoxFit.cover),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          labelStyle:
                              TextStyle(color: kTextColor, fontSize: 17),
                          errorStyle: TextStyle(color: kIconColor),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          hintText: 'e.g. Intern',
                          labelText: 'Enter movie name',
                        ),
                        cursorColor: Colors.white,
                        initialValue: movieName,
                        onChanged: (newName) {
                          movieName = newName;
                        },
                        validator: (newName) => validator(newName),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          labelStyle:
                              TextStyle(color: kTextColor, fontSize: 17),
                          errorStyle: TextStyle(color: kIconColor),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: .5, color: kIconColor),
                          ),
                          hintText: 'e.g. Nancy Meyers',
                          labelText: 'Enter director name',
                        ),
                        initialValue: directorName,
                        onSaved: (newName) {
                          directorName = newName;
                        },
                        validator: (newName) => validator(newName),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
