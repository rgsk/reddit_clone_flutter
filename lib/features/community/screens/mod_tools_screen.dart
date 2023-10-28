import 'package:flutter/material.dart';

class ModToolsScreen extends StatelessWidget {
  const ModToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mod Tools'),
      ),
      body: Column(children: [
        ListTile(
          leading: Icon(
            Icons.add_moderator,
          ),
          title: Text('Add Moderators'),
          onTap: () {},
        ),
      ]),
    );
  }
}
