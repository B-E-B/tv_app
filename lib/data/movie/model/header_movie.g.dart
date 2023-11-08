// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderMovie _$HeaderMovieFromJson(Map<String, dynamic> json) => HeaderMovie(
      kinopoiskId: json['kinopoiskId'] as int,
      description: json['description'] as String?,
      posterUrl: json['posterUrl'] as String,
    );

Map<String, dynamic> _$HeaderMovieToJson(HeaderMovie instance) =>
    <String, dynamic>{
      'kinopoiskId': instance.kinopoiskId,
      'description': instance.description,
      'posterUrl': instance.posterUrl,
    };
