import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_task/app/modules/ingredients/presentation/ingredients_page.dart';
import 'package:tech_task/app/modules/providers/ingredients_provider.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';
import 'package:tech_task/app/shared/navigation/navigation.dart';
import 'package:tech_task/app/shared/theme.dart';
import 'package:tech_task/app/shared/widgets/slide_to_get_started_widget.dart';

class SelectTimePage extends ConsumerStatefulWidget {
  const SelectTimePage({Key key}) : super(key: key);

  @override
  ConsumerState<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends ConsumerState<SelectTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onDateTimeChanged: (_) {},
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

  SlideToGetStartedWidget slider(BuildContext context) {
    return SlideToGetStartedWidget(
      onConfirm: () {
        ref.read(ingredientsProvider.notifier).getIngredients(
          onError: (error) {
            log('error: $error');
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
