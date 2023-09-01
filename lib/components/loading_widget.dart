import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flash_chat_flutter/constants.dart';

class LoadingWidget extends StatelessWidget{

  const LoadingWidget({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: const Column(
        children: [
          SizedBox(height: 20),
          SpinKitWave(color: kFlashColor),
        ],
      ),
    );
  }

}

