import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'package:graduation_project/view/user/screens/facts.dart';
import 'package:graduation_project/view/user/screens/login.dart';
import 'package:graduation_project/view/user/screens/question.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/screens/signup.dart';
import 'view/user/screens/home.dart';
import 'view/user/screens/library.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const
            // Login();
            SafeArea(child: StartPage());
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
      }),
  GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const Signup();
      }),
  GoRoute(
      path: '/facts',
      builder: (BuildContext context, GoRouterState state) {
        return const Fact();
      }),
  GoRoute(
      path: '/question',
      builder: (BuildContext context, GoRouterState state) {
        return const Question();
      })
]);
