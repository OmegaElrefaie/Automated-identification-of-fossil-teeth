import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'package:graduation_project/view/user/screens/navbar.dart';
import 'view/user/screens/home.dart';
import 'view/user/screens/library.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      }),
  GoRoute(
      path: '/displayresults',
      builder: (BuildContext context, GoRouterState state) {
        return const DisplayResults();
      }),
  GoRoute(
      path: '/library',
      builder: (BuildContext context, GoRouterState state) {
        return const Library();
      })
]);
