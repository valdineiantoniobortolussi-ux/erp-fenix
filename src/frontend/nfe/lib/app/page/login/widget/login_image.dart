import 'package:flutter/material.dart';
import 'package:nfe/app/infra/constants.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Image.asset(
        Constants.loginImage,
    );
  }
}
