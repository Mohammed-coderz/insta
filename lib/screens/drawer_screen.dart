import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("drawer"), centerTitle: true),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: Text("data")),
              decoration: BoxDecoration(color: Colors.yellow),
            ),
            ListTile(title: Text("Home screen"), onTap: () {}),
            ExpansionTile(
              title: Text("setting"),
              children: [
                ListTile(
                  title: Text("change password"),
                  onTap: () {},
                  leading: Icon(Icons.add),
                ),
                ListTile(title: Text("change language"), onTap: () {}),
                ListTile(title: Text("change info"), onTap: () {}),
              ],
            ),
            ListTile(title: Text("Logout"), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
