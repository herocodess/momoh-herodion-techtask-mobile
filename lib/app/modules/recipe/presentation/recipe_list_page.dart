import 'package:flutter/material.dart';
import 'package:recipe_app/app/modules/recipe/presentation/recipe_page.dart';
import 'package:recipe_app/app/shared/helpers/color_constants.dart';
import 'package:recipe_app/app/shared/models/recipe_model.dart';
import 'package:recipe_app/core/navigation/navigation.dart';
import 'package:recipe_app/app/shared/theme.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({Key key, this.recipes}) : super(key: key);
  final List<RecipeModel> recipes;

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('recipe-list-page'),
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
            "Recipes List",
            style: appTheme.textTheme.headlineMedium.copyWith(
              color: blackColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              ...List.generate(widget.recipes.length, (index) {
                final subtitle = widget.recipes[index].ingredients
                    .toString()
                    .split('[')
                    .last
                    .split(']')
                    .first;
                return GestureDetector(
                  key: Key('recipe-$index'),
                  onTap: () {
                    RouteNavigators.route(
                      context,
                      RecipePage(
                        recipe: widget.recipes[index],
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: greyColor,
                          child: Text(
                            widget.recipes[index].title[0] +
                                widget.recipes[index].title[1].toUpperCase(),
                            style: appTheme.textTheme.titleLarge.copyWith(
                              color: blackColor,
                            ),
                          ),
                        ),
                        title: Text(
                          widget.recipes[index].title,
                          style: appTheme.textTheme.titleLarge.copyWith(
                            color: blackColor,
                          ),
                        ),
                        subtitle: Text(
                          subtitle,
                          style: appTheme.textTheme.bodyMedium.copyWith(
                            color: blackColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                      const Divider(
                        color: greyColor,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              })
            ],
          ),
        ));
  }
}
