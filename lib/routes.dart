import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:graduation_project/view/Expert/screens/chat_expert.dart';
import 'package:graduation_project/view/user/screens/change_password.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'package:graduation_project/view/user/screens/editprofile.dart';
import 'package:graduation_project/view/user/screens/facts.dart';
import 'package:graduation_project/view/user/screens/fossil_map.dart';
import 'package:graduation_project/view/user/screens/chat.dart';
import 'package:graduation_project/view/user/screens/login.dart';
import 'package:graduation_project/view/user/screens/question.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/screens/signup.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/user/screens/timeline_fossils.dart';
import 'package:graduation_project/view/user/screens/userprofile.dart';
import 'data/repositories/user_repo.dart';
import 'view/Expert/screens/settings_expert.dart';
import 'view/Expert/screens/startpage_expert.dart';
import 'view/user/screens/library.dart';
import 'view/user/screens/setting.dart';
import 'package:graduation_project/view/user/screens/detail_page.dart';
import 'package:graduation_project/view/Expert/screens/notifications_sending.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
        // return Headerr();
        // return const StartPage();
      }),
  GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        //return const Login();
        return const Login();
      }),
  GoRoute(
      path: '/change_password',
      builder: (BuildContext context, GoRouterState state) {
        //return const Login();
        return const ChangePassword();
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
  GoRoute(
      path: '/question',
      builder: (BuildContext context, GoRouterState state) {
        return const Question(); // pass the user instance as a positional argument
      }),
  GoRoute(
    path: '/chat',
    builder: (BuildContext context, GoRouterState state) {
      final userId = UserRepository.instance.getFirebaseUid();
      final friendId = state.params['friendId']!;
      final friendName = state.params['friendName']!;
      return Question2(
        userId: userId,
        friendId: friendId,
        friendName: friendName,
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
        return const StartPageExpert();
      }),
  GoRoute(
      path: '/settings_expert',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingExpert();
      }),
  GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const Setting();
      }),
  GoRoute(
      path: '/change-password',
      builder: (BuildContext context, GoRouterState state) {
        return const ChangePassword();
      }),
  GoRoute(
      path: '/detail_page',
      builder: (BuildContext context, GoRouterState state) {
        return DetailPage(
          fossil: state.extra as Fossil,
        );
      }),
  GoRoute(
      path: '/notifications_sending',
      builder: (BuildContext context, GoRouterState state) {
        return CustomNotification();
      })
]);
