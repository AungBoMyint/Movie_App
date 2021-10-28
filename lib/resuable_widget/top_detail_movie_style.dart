import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/json_model/detail_movie.dart';
import 'package:movie_app/model/json_model/movie.dart';

class TopDetailStyleWidget extends StatelessWidget {
  final Movie? movie;
  final DetailMovie detailMovie;
  const TopDetailStyleWidget(
      {Key? key, required this.movie, required this.detailMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Stack(
        children: [
          ///For BackGround
          Positioned(
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
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
                  return const Text("Image not available");
                },
                imageUrl: movie?.background_image == null
                    ? "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png"
                    : "https://image.tmdb.org/t/p/w500${movie?.background_image}",
                fit: BoxFit.fill,
              ),
            ),
          ),

          ///For Cover Grey Container
          Positioned(
            child: Container(color: Colors.grey.withOpacity(0.6)),
          ),

          ///For Poster Image
          Positioned(
            left: 15,
            bottom: 10,
            child: SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.2,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    return const Text("Image not available");
                  },
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${movie?.poster_image}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          ///For Other Detail
          Positioned(
              left: size.width * 0.35,
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
                              movie?.title ?? "",
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
                            movie?.release_date ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      ///Fro Start Rate Count
                      Row(
                        children: [
                          Text(
                            movie!.vote_average.toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          for (int i = 1; i < 6; i++)
                            if ((i + 0.5) < movie!.vote_average / 2 &&
                                ((movie!.vote_average / 2) ==
                                    (movie!.vote_average.round() + 0.75)) &&
                                i == movie!.vote_average.round())
                              const Icon(
                                FontAwesomeIcons.solidStarHalf,
                                color: Colors.yellow,
                                size: 10,
                              )
                            else if ((i + 0.5) > movie!.vote_average / 2)
                              const Icon(
                                FontAwesomeIcons.star,
                                color: Colors.yellow,
                                size: 10,
                              )
                            else if ((i + 0.5) < movie!.vote_average / 2)
                              const Icon(FontAwesomeIcons.solidStar,
                                  color: Colors.yellow, size: 10)
                        ],
                      ),

                      ///For Genre Type
                      Wrap(
                        children: [
                          for (int i = 0; i < detailMovie.genres.length; i++)
                            Text(
                              i == 0
                                  ? detailMovie.genres[i].name
                                  : "/${detailMovie.genres[i].name}",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                        ],
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
