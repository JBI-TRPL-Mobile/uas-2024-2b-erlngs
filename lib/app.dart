import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/message_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/notification_screen.dart';

Widget createApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Wireframe App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/welcome',  // Ubah ke /welcome
    routes: {
      '/welcome': (context) => WelcomeScreen(),
      '/': (context) => LoginScreen(),
      '/signup': (context) => SignupScreen(),
      '/home': (context) => HomeScreen(),
      '/messages': (context) => MessagesScreen(),
      '/profile': (context) => ProfileScreen(),
      '/notifications': (context) => NotificationsScreen(),
    },
  );
}

