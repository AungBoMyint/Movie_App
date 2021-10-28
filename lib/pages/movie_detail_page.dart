import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/network_http/http_request.dart';
import 'package:movie_app/pages/see_all_movie_page.dart';
import 'package:movie_app/provider/change_provider.dart';
import 'package:movie_app/resuable_widget/cast_list_widget.dart';
import 'package:movie_app/resuable_widget/companies_list_widget.dart';
import 'package:movie_app/resuable_widget/crew_list_widget.dart';
import 'package:movie_app/resuable_widget/recommendation_movie_widget.dart';
import 'package:movie_app/resuable_widget/top_detail_movie_style.dart';
import 'package:movie_app/resuable_widget/video_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/model/parser.dart';

class MovieDetialPage extends StatefulWidget {
  final Movie? currentMovie;
  const MovieDetialPage({Key? key, required this.currentMovie})
      : super(key: key);

  @override
  State<MovieDetialPage> createState() => _MovieDetialPageState();
}

class _MovieDetialPageState extends State<MovieDetialPage> {
  //Detail Movies Request From API
  late final Future<DetailMovie> detailMovie;

  ///Credit Request From API
  late final Future<Credit> credit;

  ///Video Of Current Movie Belong To Request From API
  late final Future<VideoList> videoList;

  ///Recommendation Movie Request Form API fro Current Movie
  late final Future<MoviesWithSomething> reMo;

  ///Google Translate Data From API for current Movie

  @override
  void initState() {
    ///All Request For This Current Movie
    detailMovie = HTTPRequest(endPoint: "/movie/${widget.currentMovie?.id}")
        .executeGet<DetailMovie>(DetailMovieParser());
    credit = HTTPRequest(endPoint: "/movie/${widget.currentMovie?.id}/credits")
        .executeGet<Credit>(CreditPraser());
    videoList =
        HTTPRequest(endPoint: "/movie/${widget.currentMovie?.id}/videos")
            .executeGet<VideoList>(VideoListParser());
    reMo = HTTPRequest(
            endPoint: "/movie/${widget.currentMovie?.id}/recommendations")
        .executeGet<MoviesWithSomething>(MoviesWithSomethingParser());
    ///API Request for Google Translate
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Provider For Video List
    final provider = Provider.of<ChangeProvider>(context, listen: false);
    return Scaffold(
        //appBar: AppBar(),
        body: FutureBuilder(
            future: Future.wait([detailMovie, credit, videoList, reMo]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
              if (snapshot.hasData) {
                final List<Object>? data = snapshot.data;
                final detailMovie = data?[0] as DetailMovie;
                final credit = data?[1] as Credit;
                final videoList = data?[2] as VideoList;
                final recommendationMovie = data?[3] as MoviesWithSomething;

                ///Begin Loop to Assign Controller For YouTube Video Widget
                provider.beginYoutubePlayerController(videoList.results);
                /////

                ///List View For All Detail Movie Widget
                return ListView(
                  children: [
                    ///Top
                    TopDetailStyleWidget(
                        movie: widget.currentMovie, detailMovie: detailMovie),

                    ///Space
                    const SizedBox(
                      height: 5,
                    ),

                    ///Story Line Widget
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Text(
                        "Storyline",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ////Overview Of Current Movie

                    Consumer<ChangeProvider>(
                        builder: (context,provider,__){
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    ////For Overview Text
                                    SingleChildScrollView(
                                        child:
                                        Text(provider.isTranslate ? 'Sorry!we need to subscribe plan' :
                                        widget.currentMovie?.overview ?? '',
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white.withOpacity(0.9),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15))),
                                    ///For Button
                                    const SizedBox(height: 5),
                                    provider.isTranslate ?
                                    TextButton(
                                      child: Text(
                                          "Original.",
                                          style: GoogleFonts.lobster(color: Colors.green)
                                      ),
                                      onPressed: (){
                                        provider.setTranslate(false);
                                      },
                                    ) :
                                    TextButton(
                                      child: Text(
                                          "See Translation.",
                                          style: GoogleFonts.lobster(color: Colors.green)
                                      ),
                                      onPressed: (){
                                        provider.setTranslate(true);
                                      },
                                    )
                                  ]
                              )
                              ),
                            );
                        }),
                    ///Space
                    const SizedBox(
                      height: 10,
                    ),

                    ///Cast For Current Movie Widget
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text(
                        "Cast",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CastListWidget(castList: credit.cast),

                    ///Space
                    const SizedBox(
                      height: 5,
                    ),

                    ///Crew List For Current Movie
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text(
                        "Crew",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CrewListWidget(crewList: credit.crew),

                    ///Companies List For Current Movie
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5),
                      child: Text(
                        "Companies",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CompaniesListWidget(detailMovie: detailMovie),

                    ///Space
                    const SizedBox(
                      height: 0,
                    ),

                    ///Gallery Video List For Current Movie
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const VideoListWidget(),

                    ///Recommendation Movies List For this Current Movie
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recommendation",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          TextButton(
                              onPressed: () {
                                ///Next Screen See All Page, Route Pushing
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SellAllMoviesPage(
                                    endPoint:
                                        "/movie/${widget.currentMovie?.id}/recommendations",

                                    ///For Title
                                    title: "Recommendation Movies",
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
                    RecommendationMoviesWidget(recomMovies: recommendationMovie)
                  ],
                );
              }

              if (snapshot.hasError) {
                return ErrorWidget("SnapShot Error: ${snapshot.error}");
              }

              return const Center(
                  child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ));
            }));
  }
}
