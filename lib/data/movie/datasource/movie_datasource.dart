import 'package:movie_list_app/data/movie/model/header_movie.dart';
import 'package:movie_list_app/data/movie/model/movie.dart';

abstract class MovieDataSourceRemote {
  Future<List<Movie>> fetchPopularMovies(int page);

  Future<List<Movie>> fetchBestMovies(int page);

  Future<HeaderMovie> fetchMovieAtId(int filmId);
}
