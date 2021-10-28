import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/model.dart';
import 'package:movie_app/model/parser.dart';
import 'package:movie_app/network_http/http_request.dart';
import 'package:movie_app/pages/movie_detail_page.dart';
import 'package:movie_app/pages/see_all_movie_page.dart';
import 'package:movie_app/provider/change_provider.dart';
import 'package:provider/provider.dart';

class GenreListWidget extends StatefulWidget {
  final GenreList genreList;
  const GenreListWidget({Key? key, required this.genreList}) : super(key: key);

  @override
  State<GenreListWidget> createState() => _GenreListWidgetState();
}

class _GenreListWidgetState extends State<GenreListWidget> {
  @override
  Widget build(BuildContext context) {
    final changeProvider = context.read<ChangeProvider>();
    final size = MediaQuery.of(context).size;
    final data = widget.genreList;

    return SizedBox(
      //width: size.width,
      height: size.height * 0.55,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          //Genre List Weidget
          genreListWidget(data, context, changeProvider),
          //Space
          const SizedBox(
            height: 5,
          ),
          //See All
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ///Next Screen See All Page, Route Pushing
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SellAllMoviesPage(
                        endPoint: "/discover/movie",
                        extraQuery: {
                          "with_genres":
                              "${data.genres[changeProvider.currentGenreIndex].id}"
                        },

                        ///For Title
                        title:
                            data.genres[changeProvider.currentGenreIndex].name,
                      ),
                    ));
                  },
                  child: const Text("See All",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))),
          //Movies List of current Genre
          Consumer<ChangeProvider>(builder: (context, provider, __) {
            return FutureBuilder<MoviesWithSomething>(
                future: HTTPRequest(endPoint: "/discover/movie", extraQuery: {
                  "with_genres":
                      "${data.genres[changeProvider.currentGenreIndex].id}"
                }).executeGet<MoviesWithSomething>(MoviesWithSomethingParser()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    //MoviesList Of Genre List
                    return moviesListOfGenreList(data, size);
                  }
                  if (snapshot.hasError) {
                    return ErrorWidget("Error Movie's List Of Data");
                  }
                  return const CircularProgressIndicator();
                });
          })
        ]),
      ),
    );
  }

  //Movies List of Current Genre Type
  Widget moviesListOfGenreList(MoviesWithSomething? data, Size size) {
    return data?.results == null
        ?
        //If Movies List for this current genre is null
       const Text("Sorry! there is no movies for this type")
        :
        //OR
        SizedBox(
            height: size.height * 0.4,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = data?.results[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MovieDetialPage(currentMovie: movie)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.5,
                              height: size.height * 0.3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, status) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          value: status.progress,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, whatever) {
                                    return const Text("Image not available");
                                  },
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w500${data?.results[index].poster_image}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, top: 5),
                              width: 150,
                              height: 20,
                              child: Text(
                                data?.results[index].title ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            //Star Rate Count
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      for (int i = 1; i < 6; i++)
                                        if ((i + 0.5) <
                                                data!.results[index]
                                                        .vote_average /
                                                    2 &&
                                            ((data.results[index].vote_average /
                                                    2) ==
                                                (data.results[index]
                                                        .vote_average
                                                        .round() +
                                                    0.75)) &&
                                            i ==
                                                data.results[index].vote_average
                                                    .round())
                                          const Icon(
                                            FontAwesomeIcons.solidStarHalf,
                                            color: Colors.yellow,
                                            size: 10,
                                          )
                                        else if ((i + 0.5) >
                                            data.results[index].vote_average /
                                                2)
                                          const Icon(
                                            FontAwesomeIcons.star,
                                            color: Colors.yellow,
                                            size: 10,
                                          )
                                        else if ((i + 0.5) <
                                            data.results[index].vote_average /
                                                2)
                                          const Icon(FontAwesomeIcons.solidStar,
                                              color: Colors.yellow, size: 10)
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data?.results[index].vote_average
                                            .toString() ??
                                        "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                            /////////
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: data?.results.length ?? 1),
          );
  }

  //Genre List Widget
  Widget genreListWidget(
      GenreList? data, BuildContext context, ChangeProvider changeProvider) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Consumer<ChangeProvider>(builder: (context, provider, __) {
              return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: provider.currentGenreIndex == index
                          ? Colors.green
                          : Colors.grey,
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () {
                    //When press this button,we set current genre's index to provider to change content
                    changeProvider.setCurrentGenreIndex(index);
                  },
                  child: Text(
                    data?.genres[index].name ?? "",
                    style: GoogleFonts.lobster(
                        fontWeight: FontWeight.bold,
                        color: provider.currentGenreIndex == index
                            ? Colors.white
                            : Colors.grey[800],
                        fontSize: 15),
                  ));
            });
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          },
          itemCount: data!.genres.length),
    );
  }
}
