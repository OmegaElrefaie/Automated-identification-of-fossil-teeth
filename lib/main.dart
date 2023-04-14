import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graduation_project/view/user/widgets/notifications.dart';
import 'routes.dart';
import 'constants.dart';
//import 'package:image_picker/image_picker.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  // FlutterNativeSplash.remove();
  final x = App_Notification();
  x.notifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: kPrimaryColor,
            ),
      ),
    );
  }
}
