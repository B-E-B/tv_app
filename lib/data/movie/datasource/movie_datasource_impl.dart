import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_list_app/data/movie/datasource/movie_datasource.dart';
import 'package:movie_list_app/data/movie/model/header_movie.dart';
import 'package:movie_list_app/data/movie/model/movie.dart';

@Singleton(as: MovieDataSourceRemote)
class MovieDataSourceRemoteImpl extends MovieDataSourceRemote {
  final Dio dio = Dio();

  @override
  Future<List<Movie>> fetchPopularMovies(int page) async {
    final response = await dio.get(
      'https://kinopoiskapiunofficial.tech/api/v2.2/films/top',
      queryParameters: {
        "type": "TOP_100_POPULAR_FILMS",
        "page": page,
      },
      options: Options(headers: {
        "X-API-Key": "e30ffed0-76ab-4dd6-b41f-4c9da2b2735b",
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<Movie> movies = List<Movie>.from(response.data["films"].map((movieData) => Movie.fromJson(movieData)));
      return movies;
    } else {
      throw Exception("Failed to load films");
    }
  }

  @override
  Future<HeaderMovie> fetchMovieAtId(int filmId) async {
    final response = await dio.get(
      'https://kinopoiskapiunofficial.tech/api/v2.2/films/$filmId',
      options: Options(headers: {
        "X-API-Key": "e30ffed0-76ab-4dd6-b41f-4c9da2b2735b",
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final HeaderMovie movie = HeaderMovie.fromJson(response.data);

      return movie;
    } else {
      throw Exception("Failed to load film");
    }
  }

  @override
  Future<List<Movie>> fetchBestMovies(int page) async {
    final response = await dio.get(
      'https://kinopoiskapiunofficial.tech/api/v2.2/films/top',
      queryParameters: {
        "page": page,
      },
      options: Options(headers: {
        "X-API-Key": "e30ffed0-76ab-4dd6-b41f-4c9da2b2735b",
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List<Movie> movies = List<Movie>.from(response.data["films"].map((movieData) => Movie.fromJson(movieData)));
      return movies;
    } else {
      throw Exception("Failed to load films");
    }
  }
}
