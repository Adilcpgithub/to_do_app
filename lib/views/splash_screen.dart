import 'package:flutter/material.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/widgets/splash_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashWidget splashWidget = SplashWidget();
  @override
  void initState() {
    splashWidget.goToHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          splashWidget.showLottiesAnimation(),
          splashWidget.showAppName(),
        ],
      ),
    );
  }
}
