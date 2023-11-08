class MovieEntity {
  final int filmId;
  final String nameRu;
  final String posterUrl;
  final String posterUrlPreview;
  final String? ratingKinopoisk;

  MovieEntity({
    required this.filmId,
    required this.nameRu,
    required this.posterUrl,
    required this.posterUrlPreview,
    required this.ratingKinopoisk,
  });
}
