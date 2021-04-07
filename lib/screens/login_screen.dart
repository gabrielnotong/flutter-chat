import 'package:chat/components/rounded_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  bool showSpinner = false;
  String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  enabledBorder: kEnabledLoginBorder,
                  focusedBorder: kFocusedLoginBorder,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  enabledBorder: kEnabledLoginBorder,
                  focusedBorder: kFocusedLoginBorder,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    UserCredential credential =
                        await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (credential.user != null) {
                      Navigator.pushNamed(context, ChatScreen.route);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    DangerAlertBox(
                      context: context,
                      title: 'ERROR',
                      messageText: e.message,
                      messageTextColor: Colors.red,
                      buttonText: 'Close',
                      buttonTextColor: Colors.white,
                      buttonColor: Colors.red,
                    );
                  }
                },
                color: Colors.lightBlueAccent,
                text: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
