import 'package:flutter/material.dart';

class ListViewBuilderScreen extends StatefulWidget {
  const ListViewBuilderScreen({super.key});

  @override
  State<ListViewBuilderScreen> createState() => _ListViewBuilderScreenState();
}

class _ListViewBuilderScreenState extends State<ListViewBuilderScreen> {
  List<String> names = ["mohammed", "sameer", "yousef", "marah", "mohammed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("list view builder"), centerTitle: true),
      body: ListView.builder(
        itemCount: names.length,
        // separatorBuilder: (context, index) {
        //   return SizedBox(height: 10,);
        // },
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            color: Colors.amber[600],
            child: Center(child: Text(names[index])),
          );
        },
      ),
    );
  }
}
