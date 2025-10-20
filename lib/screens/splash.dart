import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/core/shared_preferences_helper.dart';
import 'package:untitled7/screens/home_screen.dart';
import 'package:untitled7/screens/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goTo();
  }

  goTo() {
    Future.delayed(Duration(seconds: 3), () async {

      final String? remember = await SharedPreferencesHelper.getString('accessToken');
      print("remember me value is : $remember");
      if (remember != null) {

      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
