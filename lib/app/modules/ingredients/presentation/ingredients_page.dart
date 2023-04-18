import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/app/modules/providers/recipe_provider.dart';
import 'package:recipe_app/app/modules/recipe/presentation/recipe_list_page.dart';
import 'package:recipe_app/app/shared/helpers/color_constants.dart';
import 'package:recipe_app/app/shared/models/ingredients_model.dart';
import 'package:recipe_app/core/navigation/navigation.dart';
import 'package:recipe_app/app/shared/widgets/continue_button_widget.dart';

class IngredientsPage extends ConsumerStatefulWidget {
  const IngredientsPage({Key key, this.ingredients}) : super(key: key);
  final List<IngredientsModel> ingredients;

  @override
  ConsumerState<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends ConsumerState<IngredientsPage> {
  @override
  void initState() {
    super.initState();
    print('this is the ingredients ${widget.ingredients}');
  }

  List<Map<int, String>> selectedIngredientsMap = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('ingredients-page'),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ref.watch(recipeProvider).when(
              data: (data) {
                return MainButtonWidget(
                  key: Key('main-button'),
                  text: 'Continue',
                  onPressed: () {
                    ref.read(recipeProvider.notifier).getRecipes(
                      selectedIngredientsMap
                          .map((e) => e.values.first)
                          .toList(),
                      onError: (error) {
                        print(error);
                      },
                      onSuccess: (data) {
                        RouteNavigators.route(
                          context,
                          RecipeListPage(
                            recipes: data,
                          ),
                        );
                      },
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    RouteNavigators.pop(context);
                  },
                ),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(),
              ],
            ),
            SizedBox(height: 20),
            ...List.generate(
                widget.ingredients
                    .where((e) => e.useBy.isBefore(DateTime.now()))
                    .toList()
                    .length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    key: Key('ingredient-$index'),
                    value: widget.ingredients[index].useBy.isBefore(
                          DateTime.now(),
                        ) &&
                        selectedIngredientsMap
                            .where((e) =>
                                e.values.first ==
                                widget.ingredients[index].title)
                            .toList()
                            .isNotEmpty,
                    activeColor: blackColor,
                    onChanged: (value) {
                      setState(() {
                        //check if the ingredient is already in the list, else add it
                        if (selectedIngredientsMap
                            .where((e) =>
                                e.values.first ==
                                widget.ingredients[index].title)
                            .toList()
                            .isEmpty) {
                          selectedIngredientsMap.add({
                            index: widget.ingredients[index].title,
                          });
                        } else {
                          selectedIngredientsMap.removeWhere((e) =>
                              e.values.first ==
                              widget.ingredients[index].title);
                        }
                      });
                    },
                    title: Text(
                      widget.ingredients[index].title,
                    ),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
