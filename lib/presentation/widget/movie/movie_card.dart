import 'package:flutter/material.dart';
import 'package:movie_list_app/common/theme/app_colors.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final ImageProvider poster;
  final bool isSelected;
  final void Function()? onTap;

  const MovieCard({
    super.key,
    this.isSelected = false,
    required this.movie,
    required this.poster,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleSmall;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: ShapeDecoration(
                  gradient: isSelected ? AppColors.verticalPurpleBlueGradient : null,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2, color: AppColors.background),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: poster,
                      width: 200,
                      height: 320,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 14,
                top: 14,
                child: Container(
                  height: 24,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    gradient: AppColors.purpleBlueGradient,
                  ),
                  child: Text(
                    '${movie.ratingKinopoisk}',
                    style: titleStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: Text(
              movie.nameRu,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: titleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
