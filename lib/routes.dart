import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/Expert/screens/homeexpert.dart';
import 'package:graduation_project/view/user/screens/changepassword.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'package:graduation_project/view/user/screens/editprofile.dart';
import 'package:graduation_project/view/user/screens/facts.dart';
import 'package:graduation_project/view/user/screens/fossil_map.dart';
import 'package:graduation_project/view/user/screens/chat.dart';
import 'package:graduation_project/view/user/screens/login.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/screens/signup.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/user/screens/timeline_fossils.dart';
import 'package:graduation_project/view/user/screens/userprofile.dart';
import 'view/user/screens/library.dart';
import 'view/user/screens/setting.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        //return const Login();
        return const StartPage();
      }),
  GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        //return const Login();
        return const Login();
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
      path: '/fossil_map',
      builder: (BuildContext context, GoRouterState state) {
        return const FossilMap();
      }),
  GoRoute(
      path: '/timeline_fossils',
      builder: (BuildContext context, GoRouterState state) {
        return const TimeLine_fossils();
      }),
  // GoRoute(
  //     path: '/question',
  //     builder: (BuildContext context, GoRouterState state) {
  //        return Question();
  //     }),
  GoRoute(
    path: '/chat',
    builder: (BuildContext context, GoRouterState state) {
      return Question2(
        currentUser: UserModel(
          id: 'C6rjeHZUimSKyBqUHqV0LChtbBg2',
          username: 'Hagar',
          email: 'hagar@gmail.com',
          //profilepic: 'assets/images/asset3.png',
        ),
        friendId: 'z4bQLoimq8a99z2SW6kkslUHd4g1',
        friendName: 'Sara',
        // friendImage: 'assets/images/asset3.png',
      );
    },
  ),

  GoRoute(
      path: '/userprofile',
      builder: (BuildContext context, GoRouterState state) {
        return const UserProfile();
      }),
  GoRoute(
      path: '/editprofile',
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfile();
      }),
  GoRoute(
      path: '/startpage',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      }),
  GoRoute(
      path: '/home_expert',
      builder: (BuildContext context, GoRouterState state) {
        return Headerr();
      }),
  GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const Setting();
      }),
  GoRoute(
      path: '/change-password',
      builder: (BuildContext context, GoRouterState state) {
        return const ChangePasswordScreen();
      })
]);
