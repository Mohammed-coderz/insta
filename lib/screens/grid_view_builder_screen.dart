import 'package:flutter/material.dart';

class GridViewBuilderScreen extends StatefulWidget {
  const GridViewBuilderScreen({super.key});

  @override
  State<GridViewBuilderScreen> createState() => _GridViewBuilderScreenState();
}

class _GridViewBuilderScreenState extends State<GridViewBuilderScreen> {
  List<String> names = ["mohammed", "sameer", "yousef", "marah", "mohammed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("grid view builder"), centerTitle: true),
      body: GridView.builder(

        // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //   maxCrossAxisExtent: 300,
        // ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              color: Colors.amber[600],
              child: Center(child: Text(names[index])),
            ),
          );
        },
      ),
    );
  }
}
