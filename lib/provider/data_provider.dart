import 'package:movie_app/model/model.dart';
import 'package:movie_app/model/parser.dart';
import 'package:movie_app/network_http/http_request.dart';

class DataProvider {
  Movie? detailMovie;

  //Future<MoviesWithSomething> categoryMoviesList = [];

  ///Popular Movies Object
  MoviesWithSomething? popularMovies;

  ///Get Request Popular Movies From API
  void getPopularMovies(String endPoint) async {
    if (popularMovies == null) {
      popularMovies = await HTTPRequest(endPoint: endPoint)
          .executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
    }
  }

  ///Upcoming Movies Object
  MoviesWithSomething? upcomingMovies;

  ///Get Request Popular Movies From API
  void getUpcomingMovies(String endPoint) async {
    if (popularMovies == null) {
      upcomingMovies = await HTTPRequest(endPoint: endPoint)
          .executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
    }
  }
}
