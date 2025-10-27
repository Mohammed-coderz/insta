import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/core/const/svg_constant.dart';
import '../../../../core/const/api_const.dart';
import '../../../../core/const/json_body_const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRememberMe = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("login".tr()),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              if (context.locale.languageCode == 'ar') {
                context.setLocale(Locale('en'));
              } else {
                context.setLocale(Locale('ar'));
              }
            },
            icon: Icon(Icons.language),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(SvgConstant.logo),
                Text(
                  "welcome".tr(),
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
                SizedBox(height: h * 0.01),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text("email"),
                    // labelStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: h * 0.01),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("password"),
                    labelStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.password),
                  ),
                ),
                SizedBox(height: h * 0.01),

                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isRememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          isRememberMe = value!;
                        });
                        print("remember me value is : $isRememberMe");
                      },
                    ),
                    Text("remember me"),
                  ],
                ),
                SizedBox(height: h * 0.01),
                ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    final bool? remember = prefs.getBool('isRememberMe');
                    print("remember me value is : $remember");
                  },
                  child: Text("test"),
                ),

                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isRememberMe', isRememberMe);

                          // login(
                          //   phone: emailController.text,
                          //   password: passwordController.text,
                          // );
                        },

                        child: Text("login"),
                      ),
                SizedBox(height: h * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Text("data")),
                        );
                      },
                      child: Text("Signup"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
