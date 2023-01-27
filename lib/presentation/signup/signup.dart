import 'dart:developer';

import 'package:fambridge/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/getx_routes_manager.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () async {
              await AuthService.firebase().signInWithGoogle();
              Get.offNamed(Routes.mainRoute);
            },
            icon: const Icon(Icons.login),
            label: const Text("continue with google")),
      ),
    );
  }
}
