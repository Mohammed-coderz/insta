import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Image.asset("assets/images/logo.jpeg")
      // Image.network(
      //   "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
      // ),
    );
  }
}
