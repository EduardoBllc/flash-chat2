import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import '../constants.dart';
import '../components/my_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_scren';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controlador;
  late Animation animacaoImagem;
  late Animation animacaoCor;

  @override
  void initState() {
    super.initState();

    controlador = AnimationController(
      upperBound: 1,
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animacaoImagem = CurvedAnimation(parent: controlador, curve: Curves.decelerate);
    animacaoCor = ColorTween(begin: Colors.grey,end: Colors.white).animate(controlador);
    controlador.forward();
    controlador.addListener(() {
      setState(() {});
    });
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    super.dispose();
    controlador.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animacaoCor.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animacaoImagem.value * 100,
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash chat',
                      speed: Duration(milliseconds: 200),
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            MyButton(
              color: kLoginButtonColor,
              text: 'Log in',
              onPressed: () {
                Navigator.pushNamed(context, kLoginScreenId);
              },
            ),
            MyButton(
              color: kRegisterButtonColor,
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, kRegistrationScreenId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
