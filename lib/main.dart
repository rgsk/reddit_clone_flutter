import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/error_text.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
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
                    // if user is present in auth
                    // then update the userProvider
                    ref
                        .watch(authControllerProvider.notifier)
                        .getUserData(user.uid)
                        .first
                        .then((userModel) => ref
                            .read(userProvider.notifier)
                            .update((state) => userModel));

                    return loggedInRoutes;
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
