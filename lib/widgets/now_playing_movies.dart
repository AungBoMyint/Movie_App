import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/resuable_widget/now_playing_widget.dart';

class NowPlayingMoviesWidget extends StatefulWidget {
  final MoviesWithSomething nowPlayingMovies;
  const NowPlayingMoviesWidget({Key? key, required this.nowPlayingMovies})
      : super(key: key);

  @override
  State<NowPlayingMoviesWidget> createState() => _NowPlayingMoviesWidgetState();
}

class _NowPlayingMoviesWidgetState extends State<NowPlayingMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    final data = widget.nowPlayingMovies;
    return NowPlayingWidget(data: data);
  }
}
