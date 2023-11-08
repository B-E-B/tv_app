import 'package:flutter/material.dart';
import 'package:movie_list_app/common/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Color? textColor;
  final Gradient? gradient;

  const CustomButton({
    Key? key,
    required this.title,
    this.onTap,
    this.buttonColor,
    this.textColor = AppColors.white,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: 121, height: 40),
        child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: buttonColor,
                gradient: gradient,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: FittedBox(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(color: textColor),
                  ),
                ),
              ),
            )));
  }
}
