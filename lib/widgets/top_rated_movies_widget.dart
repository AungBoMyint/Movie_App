import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/resuable_widget/toprated_style_widget.dart';

class TopRatedMoviesWidget extends StatefulWidget {
  final MoviesWithSomething topRated;
  const TopRatedMoviesWidget({Key? key, required this.topRated})
      : super(key: key);

  @override
  _TopRatedMoviesWidgetState createState() => _TopRatedMoviesWidgetState();
}

class _TopRatedMoviesWidgetState extends State<TopRatedMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    final data = widget.topRated;
    return TopRatedStyleWidget(data: data);
  }
}
