import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/resuable_widget/movies_list_widget.dart';

class PopularMoviesListWidget extends StatefulWidget {
  final MoviesWithSomething popularMovies;
  const PopularMoviesListWidget({Key? key, required this.popularMovies})
      : super(key: key);

  @override
  _PopularMoviesListWidgetState createState() =>
      _PopularMoviesListWidgetState();
}

class _PopularMoviesListWidgetState extends State<PopularMoviesListWidget> {
  @override
  Widget build(BuildContext context) {
    final data = widget.popularMovies;
    return MoviesListWidget(moviesList: data);
  }
}
