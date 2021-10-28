import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/model/json_model/movies_with_something.dart';
import 'package:movie_app/pages/movie_detail_page.dart';

class TopRatedStyleWidget extends StatelessWidget {
  final MoviesWithSomething data;
  const TopRatedStyleWidget({Key? key, required this.data}) : super(key: key);

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
                    builder: (context) =>
                        MovieDetialPage(currentMovie: data.results[index])));
              },
              child: SizedBox(
                width: size.width * 0.3,
                height: size.height * 0.25,
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
                              return  const Text("Image not available");
                            },
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500${data.results[index].poster_image}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      ///Star Rated Count
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                for (int i = 1; i < 6; i++)
                                  if ((i + 0.5) <
                                          data.results[index].vote_average /
                                              2 &&
                                      ((data.results[index].vote_average / 2) ==
                                          (data.results[index].vote_average
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
                                      data.results[index].vote_average / 2)
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      color: Colors.yellow,
                                      size: 10,
                                    )
                                  else if ((i + 0.5) <
                                      data.results[index].vote_average / 2)
                                    const Icon(FontAwesomeIcons.solidStar,
                                        color: Colors.yellow, size: 10)
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data.results[index].vote_average.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
          itemCount: data.results.length),
    );
  }
}
