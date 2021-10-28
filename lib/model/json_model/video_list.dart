import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/json_model/video.dart';

part 'video_list.g.dart';

@JsonSerializable(explicitToJson: true)
class VideoList {
  final List<Video> results;
  VideoList(this.results);

  factory VideoList.fromJson(Map<String, dynamic> json) =>
      _$VideoListFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListToJson(this);
}
