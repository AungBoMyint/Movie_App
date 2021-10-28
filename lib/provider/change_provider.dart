import 'package:flutter/material.dart';
import 'package:movie_app/model/json_model/data_translate.dart';
import 'package:movie_app/model/json_model/video.dart';
import 'package:movie_app/model/json_parser/google_translate_parser.dart';
import 'package:movie_app/network_http/http_request_for_translate.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChangeProvider extends ChangeNotifier {
  int currentGenreIndex = 0;
  List<YoutubePlayerController> youtubeController = [];

  ///Current Search Text
  String? searchText;

 ///Whether is translate or not
  bool isTranslate = false;


  ///Method to translate
  void setTranslate(bool value){
    isTranslate = value;
    notifyListeners();
  }
  

  ///We notify listener everytime this method is call.
  void addSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  void setCurrentGenreIndex(int value) {
    currentGenreIndex = value;
    notifyListeners();
  }

  void beginYoutubePlayerController(List<Video> videoList) {
    youtubeController.clear();
    for (int i = 0; i < videoList.length; i++) {
      youtubeController.add(YoutubePlayerController(
        initialVideoId: videoList[i].key,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ));
    }
  }
}
