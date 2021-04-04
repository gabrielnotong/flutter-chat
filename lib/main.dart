import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/loading_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:chat/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return null;
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: WelcomeScreen.route,
            routes: {
              WelcomeScreen.route: (context) => WelcomeScreen(),
              RegistrationScreen.route: (context) => RegistrationScreen(),
              LoginScreen.route: (context) => LoginScreen(),
              ChatScreen.route: (context) => ChatScreen(),
            },
          );
        }

        return LoadingScreen();
      },
    );
  }
}
