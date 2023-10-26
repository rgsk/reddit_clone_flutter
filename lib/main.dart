import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/error_text.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone_flutter/models/user_model.dart';
import 'package:reddit_clone_flutter/router.dart';
import 'package:reddit_clone_flutter/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(WidgetRef ref, User user) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(user.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (user) => MaterialApp.router(
              title: 'Reddit',
              theme: Pallete.darkModeAppTheme,
              debugShowCheckedModeBanner: false,
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  if (user != null) {
                    getData(ref, user);
                    if (userModel != null) {
                      return loggedInRoutes;
                    }
                  }
                  return loggedOutRoutes;
                },
              ),
              routeInformationParser: RoutemasterParser(),
            ),
        error: (error, stackTrace) {
          return ErrorText(
            error: error.toString(),
          );
        },
        loading: () {
          return Loader();
        });
  }
}
