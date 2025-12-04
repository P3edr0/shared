import 'package:flutter/material.dart';
import 'package:shared/utils/assets.dart';
import 'package:shared/utils/routes/app_navigator.dart';
import 'package:shared/utils/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final navigator = AppNavigator();
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      navigator.goto(SharedRoutes.home, replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(SharedAssets.student, fit: BoxFit.cover, scale: 1),
    );
  }
}
