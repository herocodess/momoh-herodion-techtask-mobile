import 'package:flutter/material.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';
import 'package:tech_task/app/shared/models/ingredients_model.dart';
import 'package:tech_task/app/shared/navigation/navigation.dart';
import 'package:tech_task/app/shared/widgets/continue_button_widget.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key key, this.ingredients}) : super(key: key);
  final List<IngredientsModel> ingredients;

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  @override
  void initState() {
    super.initState();
    print('this is the ingredients ${widget.ingredients}');
  }

  List<Map<int, String>> selectedIngredientsMap = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: MainButtonWidget(
          text: 'Continue',
          onPressed: () {},
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
