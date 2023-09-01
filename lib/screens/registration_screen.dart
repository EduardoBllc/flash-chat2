import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/chat_screen.dart';
import '../screens/login_screen.dart';
import '../components/my_button.dart';
import '../components/my_text_fields.dart';
import '../components/loading_widget.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'resgistration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  Color requirementColor = Colors.red;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

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
                child: SizedBox(
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
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(
              height: 8.0,
            ),
            MyTextField(
              hintText: 'Enter your password',
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                  if (password.length >= 6) {
                    requirementColor = Colors.green;
                  } else {
                    requirementColor = Colors.red;
                  }
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Text(
                'Minimum: 6 characters',
                style: TextStyle(
                  color: requirementColor,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              child: Text("Already have an account? Log In"),
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            MyButton(
              color: kRegisterButtonColor,
              text: 'Register',
              onPressed: () async {
                if (email == "" || password == "") {
                  Alert(
                    context: context,
                    title: "Please fill in all the fields",
                  ).show();
                } else if (!email.contains('@')) {
                  Alert(
                    context: context,
                    title: "Please enter a valid email",
                  ).show();
                } else if (password.length < 6) {
                  Alert(
                    context: context,
                    title: "Password doesn't met the requirements: "
                        "\nMinimum: 6 characters.",
                  ).show();
                } else {
                  setState(() {
                    loading = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    setState(() {
                      loading = false;
                    });
                    Navigator.pushNamed(context, ChatScreen.id);
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    print(e);
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
