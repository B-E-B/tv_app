import 'package:movie_list_app/data/movie/model/movie.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart' as entity;

mixin MovieMapper {
  entity.MovieEntity mapFromMovieJsonToMovieEntity(Movie movie) {
    return entity.MovieEntity(
      filmId: movie.filmId,
      nameRu: movie.nameRu ?? 'Без названия',
      posterUrl: movie.posterUrl,
      posterUrlPreview: movie.posterUrlPreview,
      ratingKinopoisk: movie.rating,
    );
  }
}
