import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int filmId;
  final String? nameRu;
  final String? rating;
  final String posterUrl;
  final String posterUrlPreview;

  Movie({
    required this.filmId,
    required this.nameRu,
    required this.posterUrl,
    required this.posterUrlPreview,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
