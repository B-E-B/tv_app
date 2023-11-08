import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_list_app/domain/entity/entity.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart';
import 'package:movie_list_app/domain/movie/repository/movie_repository.dart';

@singleton
class FetchBestMoviesUseCase {
  final MovieRepository _movieRepository;

  FetchBestMoviesUseCase(this._movieRepository);

  Either<Failure, Future<List<MovieEntity>>> call(int page) {
    try {
      return Right(_movieRepository.fetchBestMovies(page));
    } catch (e, s) {
      return Left(
        Failure(
          exception: e,
          stackTrace: s,
          message: e.toString(),
        ),
      );
    }
  }
}
