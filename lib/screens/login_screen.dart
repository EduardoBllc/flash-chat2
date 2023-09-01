import 'package:flutter/material.dart';

import '../constants.dart';
import '../components/loading_widget.dart';
import '../components/my_button.dart';
import '../components/my_text_fields.dart';

import '../screens/chat_screen.dart';
import '../screens/registration_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String password = "";
  String email = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
            const SizedBox(
              height: 48.0,
            ),
            MyTextField(
              hintText: 'Enter your email',
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            MyTextField(
              obscureText: true,
              hintText: 'Enter your password',
              onChanged: (value) {
                password = value;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text("Don't have an account?"),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text('Forgot your password?'),
                    onPressed: () {
                      Alert(context: context, title: 'Please remember').show();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            MyButton(
              color: kLoginButtonColor,
              text: 'Log in',
              onPressed: () async {
                try {
                  setState(() {
                    loading = true;
                  });
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.id);
                  setState(() {
                    loading = false;
                  });
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    loading = false;
                  });
                  if (e.code == 'wrong-password') {
                    Alert(context: context, title: 'Wrong Password').show();
                  }
                }
              },
            ),
            LoadingWidget(visible: loading)
          ],
        ),
      ),
    );
  }
}
