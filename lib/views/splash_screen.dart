import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/views/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToHome();
    super.initState();
  }

  goToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
      (route) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: FadeInRight(
          duration: Duration(seconds: 1),
          child: Padding(
            padding: const EdgeInsets.only(left: 70),
            child: SizedBox(
              height: 250,
              child: Lottie.asset('asset/Animation - 1743768042387.json'),
            ),
          ),
        ),
      ),
    );
  }
}
