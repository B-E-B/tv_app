// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      filmId: json['filmId'] as int,
      nameRu: json['nameRu'] as String?,
      posterUrl: json['posterUrl'] as String,
      posterUrlPreview: json['posterUrlPreview'] as String,
      rating: json['rating'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'filmId': instance.filmId,
      'nameRu': instance.nameRu,
      'rating': instance.rating,
      'posterUrl': instance.posterUrl,
      'posterUrlPreview': instance.posterUrlPreview,
    };
