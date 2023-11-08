import 'package:movie_list_app/data/movie/model/header_movie.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> fetchPopularMovies(int page);

  Future<List<MovieEntity>> fetchBestMovies(int page);

  Future<HeaderMovie> fetchPopularMovieAtId(int filmId);
}
