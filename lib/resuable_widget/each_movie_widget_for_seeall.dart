import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/json_model/movie.dart';
import 'package:movie_app/pages/movie_detail_page.dart';

class EachMovieWidgetForSeeAllWiget extends StatelessWidget {
  final Movie movie;
  const EachMovieWidgetForSeeAllWiget({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MovieDetialPage(currentMovie: movie)));
        },
        child: SizedBox(
          height: size.height * 0.28,
          child: Stack(
            children: [
              ///For BackGround Container
              Positioned(
                left: 10,
                bottom: 0,
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),

              ///For Poster Image
              Positioned(
                left: 10,
                bottom: 0,
                child: SizedBox(
                  width: size.width * 0.35,
                  height: size.height * 0.25,
                  child: ClipRRect(
                    borderRadius:const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(20)),
                    child: CachedNetworkImage(
                      progressIndicatorBuilder: (context, url, status) {
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
                        return  const Text("Image not available");
                      },
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${movie.poster_image}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              ///For Other Detail
              Positioned(
                  left: size.width * 0.4,
                  bottom: 15,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 110,
                                child: Text(
                                  movie.title,
                                  maxLines: 4,
                                  softWrap: true,
                                  textWidthBasis: TextWidthBasis.parent,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.imFellEnglishSc(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                movie.release_date,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          ///For Start Rate Count
                          Row(
                            children: [
                              Text(
                                movie.vote_average.toString(),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              for (int i = 1; i < 6; i++)
                                if ((i + 0.5) < movie.vote_average / 2 &&
                                    ((movie.vote_average / 2) ==
                                        (movie.vote_average.round() + 0.75)) &&
                                    i == movie.vote_average.round())
                                  const Icon(
                                    FontAwesomeIcons.solidStarHalf,
                                    color: Colors.yellow,
                                    size: 15,
                                  )
                                else if ((i + 0.5) > movie.vote_average / 2)
                                  const Icon(
                                    FontAwesomeIcons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  )
                                else if ((i + 0.5) < movie.vote_average / 2)
                                  const Icon(FontAwesomeIcons.solidStar,
                                      color: Colors.yellow, size: 15)
                            ],
                          ),
                        ]),
                  ))
            ],
          ),
        ));
  }
}
