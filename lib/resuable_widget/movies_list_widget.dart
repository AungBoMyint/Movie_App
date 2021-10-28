import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/pages/movie_detail_page.dart';

class MoviesListWidget extends StatelessWidget {
  final MoviesWithSomething moviesList;
  const MoviesListWidget({Key? key, required this.moviesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetialPage(
                        currentMovie: moviesList.results[index])));
              },
              child: SizedBox(
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
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
                                "https://image.tmdb.org/t/p/w500${moviesList.results[index].poster_image}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 5),
                        width: 150,
                        height: 20,
                        child: Text(
                          moviesList.results[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
          itemCount: moviesList.results.length),
    );
  }
}
