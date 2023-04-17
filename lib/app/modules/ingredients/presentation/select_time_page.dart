import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_task/app/modules/onboarding/presentation/widgets/slide_to_get_started_widget.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';
import 'package:tech_task/app/shared/theme.dart';

class SelectTimePage extends StatefulWidget {
  const SelectTimePage({Key key}) : super(key: key);

  @override
  State<SelectTimePage> createState() => _SelectTimePageState();
}

class _SelectTimePageState extends State<SelectTimePage> {
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
                minimumDate: DateTime.now().add(Duration(days: 1)),
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (_) {},
                maximumDate: DateTime.now(),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: SlideToGetStartedWidget(
                onConfirm: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
