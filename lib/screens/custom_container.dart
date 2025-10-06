import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 10),
      ),
      child: Center(
        child: Text("qwerty", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
