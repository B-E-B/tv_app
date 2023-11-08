import 'package:injectable/injectable.dart';
import 'package:movie_list_app/data/movie/datasource/movie_datasource.dart';
import 'package:movie_list_app/data/movie/model/header_movie.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart';
import 'package:movie_list_app/domain/movie/mapper/movie_mapper.dart';
import 'package:movie_list_app/domain/movie/repository/movie_repository.dart';

@Singleton(as: MovieRepository)
class MovieRepositoryImpl extends MovieRepository with MovieMapper {
  final MovieDataSourceRemote _movieDataSourceRemote;

  MovieRepositoryImpl(
    this._movieDataSourceRemote,
  );

  @override
  Future<List<MovieEntity>> fetchPopularMovies(int page) async {
    final moviesData = await _movieDataSourceRemote.fetchPopularMovies(page);
    final movies = moviesData.map((movie) => mapFromMovieJsonToMovieEntity(movie)).toList();
    return movies;
  }

  @override
  Future<List<MovieEntity>> fetchBestMovies(int page) async {
    final moviesData = await _movieDataSourceRemote.fetchBestMovies(page);
    final movies = moviesData.map((movie) => mapFromMovieJsonToMovieEntity(movie)).toList();
    return movies;
  }

  @override
  Future<HeaderMovie> fetchPopularMovieAtId(int filmId) async {
    final movie = await _movieDataSourceRemote.fetchMovieAtId(filmId);
    return movie;
  }
}
