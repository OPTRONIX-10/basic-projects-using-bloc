import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
   SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) =>  SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
