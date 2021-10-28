import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/resuable_widget/now_playing_widget.dart';

class UpComingMoviesWidget extends StatefulWidget {
  final MoviesWithSomething upcomingMovies;
  const UpComingMoviesWidget({Key? key, required this.upcomingMovies})
      : super(key: key);

  @override
  _UpComingMoviesWidgetState createState() => _UpComingMoviesWidgetState();
}

class _UpComingMoviesWidgetState extends State<UpComingMoviesWidget> {
  //late final Future<MoviesWithSomething> _upcomingMovies;

  @override
  void initState() {
    // Get Request Upcoming Movies list From API
    /*_upcomingMovies = HTTPRequest(endPoint: "/movie/upcoming")
        .executeGet(MoviesWithSomethingParser());*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.upcomingMovies;
    return NowPlayingWidget(data: data);
  }
}
