import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';

import 'movies_list_widget.dart';

class RecommendationMoviesWidget extends StatefulWidget {
  final MoviesWithSomething recomMovies;
  const RecommendationMoviesWidget({Key? key, required this.recomMovies})
      : super(key: key);

  @override
  _RecommendationMoviesWidgetState createState() =>
      _RecommendationMoviesWidgetState();
}

class _RecommendationMoviesWidgetState
    extends State<RecommendationMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return MoviesListWidget(moviesList: widget.recomMovies);
  }
}
