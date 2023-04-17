import 'package:flutter/material.dart';
import 'package:tech_task/app/modules/ingredients/presentation/select_time_page.dart';
import 'package:tech_task/app/shared/navigation/navigation.dart';
import 'package:tech_task/app/shared/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      RouteNavigators.routeNoWayHome(context, SelectTimePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
            image: AssetImage(
              'assets/images/salad.jpeg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Cooking Experience Like a Chef',
              textAlign: TextAlign.center,
              style: appTheme.textTheme.displayMedium,
            ),
            SizedBox(height: 20),
            Text(
              "Let's make a delicious dish with the best recipe to the family",
              textAlign: TextAlign.center,
              style: appTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
