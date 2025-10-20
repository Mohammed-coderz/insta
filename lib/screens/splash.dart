import 'package:flutter/material.dart';
import 'package:untitled7/core/utils/shared_preferences_helper.dart';

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

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
