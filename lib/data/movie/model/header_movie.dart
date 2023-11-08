import 'package:json_annotation/json_annotation.dart';

part 'header_movie.g.dart';

@JsonSerializable()
class HeaderMovie {
  final int kinopoiskId;
  final String? description;
  final String posterUrl;

  HeaderMovie({
    required this.kinopoiskId,
    required this.description,
    required this.posterUrl,
  });

  factory HeaderMovie.fromJson(Map<String, dynamic> json) => _$HeaderMovieFromJson(json);

  Map<String, dynamic> toJson() => _$HeaderMovieToJson(this);
}
