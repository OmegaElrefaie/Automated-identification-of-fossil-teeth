import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:graduation_project/view/Expert/screens/homeexpert.dart';
import 'package:graduation_project/view/user/screens/changepassword.dart';
import 'package:graduation_project/view/user/screens/detail_page.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'package:graduation_project/view/user/screens/editprofile.dart';
import 'package:graduation_project/view/user/screens/facts.dart';
import 'package:graduation_project/view/user/screens/fossilMap.dart';
import 'package:graduation_project/view/user/screens/login.dart';
import 'package:graduation_project/view/user/screens/question.dart';
import 'package:graduation_project/view/user/screens/question2.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/screens/signup.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/user/screens/time1.dart';
import 'package:graduation_project/view/user/screens/timelineFossils.dart';
import 'package:graduation_project/view/user/screens/userprofile.dart';
import 'view/user/screens/library.dart';
import 'view/user/screens/setting.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
        // return const FossilMap();
        // return const TimeLine_fossils();
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
      }),
// GoRoute(
//   path: '/question2',
//   builder: (BuildContext context, GoRouterState state) {
//     return  Question2(
//       currentUser: currentUser,
//       friendId: 'friendId',
//       friendImage: 'friendImage',
//       friendName: 'friendName',
//     );
//   }
// ),
  GoRoute(
    path: '/question2',
    builder: (BuildContext context, GoRouterState state) {
      return Question2(
        currentUser: UserModel(
          id: '1',
          username: 'John Doe',
          email: 'john.doe@example.com',
          profilepic: 'https://example.com/john_doe.png',
        ),
        friendId: '2',
        friendName: 'Jane Doe',
        friendImage: 'https://example.com/jane_doe.png',
      );
    },
  ),

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

  GoRoute(
      path: '/time1',
      builder: (BuildContext context, GoRouterState state) {
        return const time1();
      }),
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
      }),
  GoRoute(
    path: '/detail_page',
    builder: (BuildContext context, GoRouterState state) {
      return DetailPage(
        fossil: state.extra as Fossil,
      );
    },
  ),
]);
