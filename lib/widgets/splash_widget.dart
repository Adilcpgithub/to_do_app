import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_app/views/home_screen.dart';

class SplashWidget {
  //! Lottie Animation
  Widget showLottiesAnimation() {
    return FadeInRight(
      duration: Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 90),
        child: SizedBox(
          height: 250,
          child: Lottie.asset('asset/Animation - 1743768042387.json'),
        ),
      ),
    );
  }

  //! App Title
  Widget showAppName() {
    return FadeInRight(
      duration: Duration(seconds: 1),
      child: SizedBox(
        child: Text(
          'Todo App',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Colors.black26,
                offset: Offset(2.0, 2.0),
              ),
            ],
            fontFamily: 'Roboto',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //! Navigation to HomePage
  goToHome(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1300),
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      (route) => false,
    );
  }
}
