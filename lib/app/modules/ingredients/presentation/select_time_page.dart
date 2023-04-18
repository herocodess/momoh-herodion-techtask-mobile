import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app/app/modules/ingredients/presentation/ingredients_page.dart';
import 'package:recipe_app/app/modules/providers/ingredients_provider.dart';
import 'package:recipe_app/app/shared/helpers/color_constants.dart';
import 'package:recipe_app/core/navigation/navigation.dart';
import 'package:recipe_app/app/shared/theme.dart';
import 'package:recipe_app/app/shared/widgets/slide_to_get_started_widget.dart';

class SelectTimePage extends ConsumerStatefulWidget {
  const SelectTimePage({Key key}) : super(key: key);

  @override
  ConsumerState<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends ConsumerState<SelectTimePage> {
  var selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('select-time-page'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              'Please choose your lunch date',
              textAlign: TextAlign.center,
              style: appTheme.textTheme.displayMedium.copyWith(
                color: blackColor,
              ),
            ),
            SizedBox(height: 50),
            Container(
              key: Key('date-picker'),
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: blackColor, width: 1.3),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(10),
              child: CupertinoDatePicker(
                backgroundColor: Colors.white,
                initialDateTime: DateTime.now(),
                minimumDate: DateTime.now().subtract(Duration(days: 1)),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (_) {
                  selectedDate = _;
                },
                maximumDate: DateTime.now().add(Duration(days: 30)),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: ref.watch(ingredientsProvider).when(
                    data: (data) => slider(context),
                    loading: () => CircularProgressIndicator(),
                    error: (error, stackTrace) {
                      return slider(context);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  SlideToBookLunchWidget slider(BuildContext context) {
    return SlideToBookLunchWidget(
      key: Key('slide-to-get-started-widget'),
      onConfirm: () {
        ref.read(ingredientsProvider.notifier).getIngredients(
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
              ),
            );
          },
          onSuccess: (data) {
            RouteNavigators.route(
              context,
              IngredientsPage(
                ingredients: data,
              ),
            );
          },
        );
      },
    );
  }
}
