import 'package:flutter/material.dart';
import 'package:untitled7/screens/login_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "welcome to our app",
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("name"),
                    // labelStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: emailController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("email"),
                    labelStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.password),
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    label: Text("password"),
                    // labelStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: confirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("confirm password"),
                    labelStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    icon: Icon(Icons.password),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    print("email is : ${emailController.text}");
                    print("password is : ${passwordController.text}");
                  },
                  child: Text("login"),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already have an account?"),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => LoginScreen()),
                        // );
                        Navigator.pop(context);
                      },
                      child: Text("login"),
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
