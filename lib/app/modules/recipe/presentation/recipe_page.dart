import 'package:flutter/material.dart';
import 'package:recipe_app/app/modules/recipe/presentation/widgets/recipe_ingredient_widget.dart';
import 'package:recipe_app/app/shared/helpers/color_constants.dart';
import 'package:recipe_app/app/shared/models/recipe_model.dart';
import 'package:recipe_app/core/navigation/navigation.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key key, this.recipe}) : super(key: key);
  final RecipeModel recipe;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('recipe-page'),
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => RouteNavigators.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.recipe.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ingredients (${widget.recipe.ingredients.length})",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            ...List.generate(
              widget.recipe.ingredients.length,
              (index) => RecipeIngredientWidget(
                title: widget.recipe.ingredients[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
