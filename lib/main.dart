import 'package:eslame_assignment/ui/home/home_screen.dart';
import 'package:eslame_assignment/ui/onboarding/onboarding_screen.dart';
import 'package:eslame_assignment/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onboardingRouteName,
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(
          onFinish: () {

            Navigator.of(context).pushReplacementNamed(
              AppRoutes.homeRouteName,
            );
          },
        ),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
      },
    );
  }
}