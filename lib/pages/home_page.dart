import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/network_http/http_request.dart';
import 'package:movie_app/model/parser.dart';
import 'package:movie_app/pages/search_movie_page.dart';
import 'package:movie_app/pages/see_all_movie_page.dart';
import 'package:movie_app/widgets/genre_list_widget.dart';
import 'package:movie_app/widgets/now_playing_movies.dart';
import 'package:movie_app/widgets/popular_movies_widget.dart';
import 'package:movie_app/widgets/top_rated_movies_widget.dart';
import 'package:movie_app/widgets/upcoming_movies_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Genre List To execute From API
  late final Future<GenreList> genreList;
  //Popular Movies To execute From API
  late final Future<MoviesWithSomething> popularMovies;
  //Top Reated Movies TO execute From API
  late final Future<MoviesWithSomething> topRatedMovies;
  //Now Playing Movies To execute From API
  late final Future<MoviesWithSomething> nowPlayingMovies;
  //UpComing Movies To execute From API
  late final Future<MoviesWithSomething> upcomingMovies;

  @override
  void initState() {
    // All in one Request
    genreList = HTTPRequest(endPoint: "/genre/movie/list")
        .executeGet<GenreList>(GenreParser());
    popularMovies = HTTPRequest(endPoint: "/movie/popular")
        .executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
    topRatedMovies = HTTPRequest(endPoint: "/movie/top_rated")
        .executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
    nowPlayingMovies = HTTPRequest(endPoint: "/movie/now_playing")
        .executeGet(MoviesWithSomethingParser());
    upcomingMovies = HTTPRequest(endPoint: "/movie/upcoming")
        .executeGet(MoviesWithSomethingParser());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "TheMovies",
            style: GoogleFonts.abhayaLibre(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0),
          actions: [
            IconButton(
                onPressed: () {
                  ///We Push SearchPage when This Search Icon is tapped.
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchMoviePage()));
                },
                icon: const Icon(Icons.search, color: Colors.white, size: 25))
          ],
        ),
        body: FutureBuilder(
            future: Future.wait([
              genreList,
              popularMovies,
              topRatedMovies,
              nowPlayingMovies,
              upcomingMovies
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
              if (snapshot.hasData) {
                final genreList = snapshot.data?[0] as GenreList;
                final popularMovies = snapshot.data?[1] as MoviesWithSomething;
                final topRatedMovies = snapshot.data?[2] as MoviesWithSomething;
                final nowPlayingMovies =
                    snapshot.data?[3] as MoviesWithSomething;
                final upcomingMovies = snapshot.data?[4] as MoviesWithSomething;

                return ListView(children: [
                  //Top Of the Screen. Genre Movies List
                  GenreListWidget(genreList: genreList),
                  //Popular Movies List's Button and Widget
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {
                              ///Next Screen See All Page, Route Pushing
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SellAllMoviesPage(
                                  endPoint: "/movie/popular",

                                  ///For Title
                                  title: "Popular Movies",
                                ),
                              ));
                            },
                            child: const Text("See All",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  PopularMoviesListWidget(popularMovies: popularMovies),

                  ///Now Playing Movies's Button and Result Widget
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Now Playing",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SellAllMoviesPage(
                                  endPoint: "/movie/now_playing",

                                  ///For Title
                                  title: "Now Playing Movies",
                                ),
                              ));
                            },
                            child: const Text("See All",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  NowPlayingMoviesWidget(nowPlayingMovies: nowPlayingMovies),
                  ////Space
                  const SizedBox(height: 10),

                  ////Top Rated Movies's Button and Widget
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Top Rated",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SellAllMoviesPage(
                                  endPoint: "/movie/top_rated",

                                  ///For Title
                                  title: "Top Rated Movies",
                                ),
                              ));
                            },
                            child: const Text("See All",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  TopRatedMoviesWidget(topRated: topRatedMovies),

                  ///Upcoming Movies's Button And Widget
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Upcoming",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SellAllMoviesPage(
                                  endPoint: "/movie/upcoming",

                                  ///For Title
                                  title: "Upcoming Movies",
                                ),
                              ));
                            },
                            child: const Text("See All",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  UpComingMoviesWidget(upcomingMovies: upcomingMovies),

                  ///Space
                  const SizedBox(height: 20)
                ]);
              }
              if (snapshot.hasError) {
                return ErrorWidget("Some snapshot error");
              }
              return const Center(
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator()),
              );
            }));
  }
}
