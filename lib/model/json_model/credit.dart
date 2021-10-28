import 'package:json_annotation/json_annotation.dart';

import 'cast.dart';
import 'crew.dart';


part 'credit.g.dart';

@JsonSerializable(explicitToJson: true)
class Credit {
  final List<Cast> cast;
  final List<Crew> crew;
  Credit(this.cast, this.crew);

  factory Credit.fromJson(Map<String, dynamic> json) => _$CreditFromJson(json);

  Map<String, dynamic> toJson() => _$CreditToJson(this);
}
