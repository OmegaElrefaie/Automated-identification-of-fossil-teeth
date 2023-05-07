import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:graduation_project/view/Expert/screens/manage_maps.dart';
import 'package:graduation_project/view/expert/screens/chat_expert.dart';
import 'package:graduation_project/view/user/screens/about_us.dart';
import 'package:graduation_project/view/user/screens/change_password.dart';
import 'package:graduation_project/view/user/screens/display_results.dart';
import 'package:graduation_project/view/user/screens/editprofile.dart';
import 'package:graduation_project/view/user/screens/facts.dart';
import 'package:graduation_project/view/user/screens/fossil_map.dart';
import 'package:graduation_project/view/user/screens/chat.dart';
import 'package:graduation_project/view/user/screens/instructions.dart';
import 'package:graduation_project/view/user/screens/login.dart';
import 'package:graduation_project/view/user/screens/question.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/screens/signup.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/user/screens/timeline_fossils.dart';
import 'package:graduation_project/view/user/screens/userprofile.dart';
import 'package:graduation_project/welcome_screen.dart';
import 'data/repositories/user_repo.dart';
import 'view/expert/screens/adding_facts_screen.dart';
import 'view/expert/screens/settings_expert.dart';
import 'view/expert/screens/startpage_expert.dart';
import 'view/user/screens/library.dart';
import 'view/user/screens/setting.dart';
import 'package:graduation_project/view/user/screens/detail_page.dart';
import 'package:graduation_project/view/expert/screens/notifications_sending.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // return const Login();
        // return const WelcomeScreen();
        return const StartPage();

        // return Instructions();
      }),
  GoRoute(
      path: '/instructions',
      name: "instructions",
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
            key: state.pageKey,
            child: Instructions(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                ((context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                  reverseCurve: Curves.bounceOut);
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            }));
      }),
  GoRoute(
      path: '/login',
      name: "login",
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      }),
  GoRoute(
      path: '/manage_maps',
      name: "manage_maps",
      builder: (BuildContext context, GoRouterState state) {
        //return const Login();
        return const FoosilMapInputScreen();
      }),
  GoRoute(
      path: '/change_password',
      name: "change_password",
      builder: (BuildContext context, GoRouterState state) {
        //return const Login();
        return const ChangePassword();
      }),
  GoRoute(
      path: '/displayresults',
      name: "displayresults",
      builder: (BuildContext context, GoRouterState state) {
        return const DisplayResults();
      }),
  GoRoute(
      path: '/library',
      name: "library",
      builder: (BuildContext context, GoRouterState state) {
        return const Library();
      }),
  GoRoute(
      path: '/signup',
      name: "signup",
      builder: (BuildContext context, GoRouterState state) {
        return const Signup();
      }),
  GoRoute(
      path: '/facts',
      name: "facts",
      builder: (BuildContext context, GoRouterState state) {
        return const FactsScreen();
      }),
  GoRoute(
      path: '/fossil_map',
      name: "fossil_map",
      builder: (BuildContext context, GoRouterState state) {
        return const FossilMap();
      }),
  GoRoute(
      path: '/timeline_fossils',
      name: "timeline_fossils",
      builder: (BuildContext context, GoRouterState state) {
        return const TimeLine_fossils();
      }),
  GoRoute(
      path: '/question',
      name: "question",
      builder: (BuildContext context, GoRouterState state) {
        return const Question(); // pass the user instance as a positional argument
      }),
  GoRoute(
    path: '/chat',
    name: "chat",
    builder: (BuildContext context, GoRouterState state) {
      final userId = UserRepository.instance.getFirebaseUid();
      final friendId = state.queryParams['friendId']!;
      final friendName = state.queryParams['friendName']!;
      return Question2(
        userId: userId,
        friendId: friendId,
        friendName: friendName,
      );
    },
  ),
  GoRoute(
      path: '/userprofile',
      name: "userprofile",
      builder: (BuildContext context, GoRouterState state) {
        return const UserProfile();
      }),
  GoRoute(
      path: '/editprofile',
      name: "editprofile",
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfile();
      }),
  GoRoute(
      path: '/startpage',
      name: "startpage",
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      }),
  GoRoute(
      path: '/home_expert',
      name: "home_expert",
      builder: (BuildContext context, GoRouterState state) {
        return const StartPageExpert();
      }),
  GoRoute(
      path: '/settings_expert',
      name: "settings_expert",
      builder: (BuildContext context, GoRouterState state) {
        return const SettingExpert();
      }),
  GoRoute(
      path: '/settings',
      name: "settings",
      builder: (BuildContext context, GoRouterState state) {
        return const Setting();
      }),
  GoRoute(
      path: '/change-password',
      name: "change-password",
      builder: (BuildContext context, GoRouterState state) {
        return const ChangePassword();
      }),
  GoRoute(
      path: '/detail_page',
      name: "detail_page",
      builder: (BuildContext context, GoRouterState state) {
        return DetailPage(
          fossil: state.extra as Fossil,
        );
      }),
  GoRoute(
      path: '/notifications_sending',
      name: "notification_sending",
      builder: (BuildContext context, GoRouterState state) {
        return const CustomNotification();
      }),
  GoRoute(
      path: '/about_us',
      name: "about_us",
      builder: (BuildContext context, GoRouterState state) {
        return AboutUsScreen();
      }),
  GoRoute(
      path: '/adding_facts',
      name: "adding_facts",
      builder: (BuildContext context, GoRouterState state) {
        return const AddingFacts();
      })
]);
