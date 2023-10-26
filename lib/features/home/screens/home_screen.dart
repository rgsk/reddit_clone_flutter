import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
          body: Center(
            child: Text(
              userModelFromStream.karma.toString(),
            ),
          ),
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
