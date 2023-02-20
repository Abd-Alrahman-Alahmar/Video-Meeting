import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_9/resources/auth_methods.dart';
import 'package:flutter_9/screens/home_screen.dart';
import 'package:flutter_9/screens/login_screen.dart';
import 'package:flutter_9/screens/sign_in_screen.dart';
import 'package:flutter_9/screens/sign_up_screen.dart';
import 'package:flutter_9/screens/splash_screen.dart';
import 'package:flutter_9/screens/video_call_screen.dart';
import 'package:flutter_9/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(), 
        '/signup-email-password': (context) => const EmailPasswordSignup(),
        '/login-email-password': (context) => const EmailPasswordLogin(),

      },
      //we use stream when there is a sequance of event
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          
          if(snapshot.hasData) {
            return const HomeScreen();
          }
          return LoginScreen();
        },
      )
    );
  }
}


