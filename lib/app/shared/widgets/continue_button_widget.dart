import 'package:flutter/material.dart';
import 'package:tech_task/app/shared/helpers/color_constants.dart';
import 'package:tech_task/app/shared/theme.dart';

class MainButtonWidget extends StatefulWidget {
  const MainButtonWidget({Key key, this.text}) : super(key: key);
  final String text;

  @override
  State<MainButtonWidget> createState() => _MainButtonWidgetState();
}

class _MainButtonWidgetState extends State<MainButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 200,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: blackColor,
      ),
      child: Center(
        child: Text(
          widget.text,
          style: appTheme.textTheme.titleLarge,
        ),
      ),
    );
  }
}
