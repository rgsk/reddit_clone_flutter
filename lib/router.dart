import 'package:flutter/material.dart';
import 'package:reddit_clone_flutter/features/auth/screens/login_screen.dart';
import 'package:reddit_clone_flutter/features/community/screens/community_screen.dart';
import 'package:reddit_clone_flutter/features/community/screens/create_community_screen.dart';
import 'package:reddit_clone_flutter/features/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(routes: {
  '/': (_) => MaterialPage(child: LoginScreen()),
});
final loggedInRoutes = RouteMap(routes: {
  '/': (_) => MaterialPage(child: HomeScreen()),
  '/create-community': (_) => MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) => MaterialPage(
          child: CommunityScreen(
        name: route.pathParameters['name']!,
      )),
});
