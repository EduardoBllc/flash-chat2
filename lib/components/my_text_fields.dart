import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.obscureText = false,
  });

  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
      onChanged: onChanged,
      textAlign: TextAlign.center,
      obscureText: obscureText,
    );
  }
}

typedef ValueChanged<T> = void Function(T value);
