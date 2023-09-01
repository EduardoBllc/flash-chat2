import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flash_chat_flutter/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';


void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
          titleMedium: TextStyle(color: Colors.black54),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle()
        ),



        hintColor: Colors.black54,
      ),
      home: WelcomeScreen(),
      routes: {
        kWelcomeScreenId : (context) => WelcomeScreen(),
        kLoginScreenId : (context) => LoginScreen(),
        kRegistrationScreenId : (context) => RegistrationScreen(),
        kChatScreenId : (context) => ChatScreen(),
      },
    );
  }
}
