import 'package:flutter/material.dart';
import 'package:movie_list_app/common/theme/app_colors.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart';

class NumberedMovieCard extends StatelessWidget {
  final MovieEntity movie;
  final ImageProvider poster;
  final int number;
  final bool isSelected;
  final void Function()? onTap;

  const NumberedMovieCard({
    super.key,
    required this.movie,
    required this.poster,
    required this.number,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.labelLarge;

    return GestureDetector(
      onTap: onTap,
      child: Stack(alignment: Alignment.centerRight, fit: StackFit.passthrough, children: [
        Padding(
          padding: const EdgeInsets.only(right: 167),
          child: SizedBox(
            height: 300,
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return AppColors.purpleBlueGradient.createShader(rect);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('$number', style: titleStyle),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: ShapeDecoration(
              gradient: isSelected ? AppColors.verticalPurpleBlueGradient : null,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Colors.transparent),
                borderRadius: BorderRadius.circular(14),
              )),
          child: Container(
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: AppColors.background),
              borderRadius: BorderRadius.circular(12),
            )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: poster,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
