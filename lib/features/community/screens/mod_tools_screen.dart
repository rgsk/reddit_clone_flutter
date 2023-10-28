import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String communityName;
  const ModToolsScreen({
    super.key,
    required this.communityName,
  });

  void navigateToCommunityScreen(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$communityName');
  }

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
        ListTile(
          leading: Icon(
            Icons.edit,
          ),
          title: Text('Edit Community'),
          onTap: () => navigateToCommunityScreen(context),
        ),
      ]),
    );
  }
}
