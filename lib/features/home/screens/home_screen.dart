import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone_flutter/features/home/drawers/community_list_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, ref) {
    final userModel = ref.watch(userProvider);
    final userStream = userModel != null
        ? ref.watch(getUserDataProvider(
            userModel.uid,
          ))
        : null;

    if (userStream == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return userStream.when(
      data: (userModelFromStream) {
        // The user data is available, and you can access it from userData.
        return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            centerTitle: false,
            leading: Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                // Why did we wrapped with Builder
                // we have to use context of child of Scaffold
                // not the context of the widget that instantiated the Scaffold
                onPressed: () => displayDrawer(context),
              );
            }),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              IconButton(
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(userModelFromStream.profilePic),
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: Center(
            child: Text(
              userModelFromStream.karma.toString(),
            ),
          ),
          drawer: CommunityListDrawer(),
        );
      },
      loading: () {
        // Data is loading, you can display a loading indicator.
        return CircularProgressIndicator();
      },
      error: (error, stackTrace) {
        // Handle the error, you can display an error message.
        return Text('Error: $error');
      },
    );
  }
}
