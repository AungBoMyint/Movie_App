import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/pages/movie_detail_page.dart';

class NowPlayingWidget extends StatelessWidget {
  final MoviesWithSomething data;
  const NowPlayingWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GFCarousel(
      autoPlay: true,
      reverse: true,
      height: size.height * 0.4,
      pagination: true,
      activeIndicator: Colors.green,
      passiveIndicator: Colors.white,
      items: data.results.map((movie) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieDetialPage(currentMovie: movie)));
          },
          child: SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.35,
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
                    "https://image.tmdb.org/t/p/w500${movie.poster_image}",
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
