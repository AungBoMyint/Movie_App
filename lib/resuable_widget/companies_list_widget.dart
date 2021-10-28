import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/model/json_model/detail_movie.dart';

class CompaniesListWidget extends StatelessWidget {
  final DetailMovie detailMovie;
  const CompaniesListWidget({Key? key, required this.detailMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.only(left: 20),
        height: size.height * 0.3,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final company = detailMovie.productionCompanies[index];
              return SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///Company Logo Image
                      SizedBox(
                        width: size.width * 0.35,
                        height: size.height * 0.2,
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
                          imageUrl: company.logoImage == null
                              ? "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png"
                              : "https://image.tmdb.org/t/p/w500${company.logoImage}",
                          fit: BoxFit.fill,
                        ),
                      ),

                      ///Space
                      const SizedBox(height: 2),

                      ///Country Of Current Company
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(company.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dancingScript(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 15,
              );
            },
            itemCount: detailMovie.productionCompanies.length));
  }
}
