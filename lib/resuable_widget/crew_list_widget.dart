import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/crew.dart';

class CrewListWidget extends StatelessWidget {
  final List<Crew> crewList;
  const CrewListWidget({Key? key, required this.crewList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.only(left: 20),
        height: size.height * 0.2,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final crew = crewList[index];
              return SizedBox(
                width: size.width * 0.3,
                height: size.height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///Profile Image
                      CircleAvatar(
                        radius: 50,
                        foregroundImage: NetworkImage(crew.profileImage == null
                            ? 'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'
                            : "https://image.tmdb.org/t/p/w500${crew.profileImage}"),
                      ),

                      ///Space
                      const SizedBox(height: 2),

                      ///Actor Name
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(crew.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
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
                width: 10,
              );
            },
            itemCount: crewList.length));
  }
}
