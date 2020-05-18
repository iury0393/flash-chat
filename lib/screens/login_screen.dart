import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/round_button.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Digite o email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Digite uma senha'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
              btnColor: Colors.lightBlueAccent,
              btnFunction: () async {
                final userLogged = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (userLogged != null) {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
              },
              btnText: 'Log in',
            ),
            RoundButton(
              btnColor: Colors.red,
              btnFunction: () {
                Navigator.pop(context);
              },
              btnText: 'Back',
            ),
          ],
        ),
      ),
    );
  }
}
