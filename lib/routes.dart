import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'view/user/screens/home.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      }),
  GoRoute(
      path: '/displayresults',
      builder: (BuildContext context, GoRouterState state) {
        return const DisplayResults();
      })
]);
