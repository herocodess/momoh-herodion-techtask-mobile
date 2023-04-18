import 'package:flutter/material.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';
import 'package:tech_task/app/shared/theme.dart';

class RecipeIngredientWidget extends StatelessWidget {
  final String title;
  RecipeIngredientWidget({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 80,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: greyColor,
              child: Text(
                title[0] + title[1].toUpperCase(),
                style: appTheme.textTheme.titleLarge.copyWith(
                  color: blackColor,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: appTheme.textTheme.bodyLarge.copyWith(
                color: blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
