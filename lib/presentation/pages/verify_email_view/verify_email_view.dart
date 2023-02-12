import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Column(
        children: [
          const Text(
              "We've sent you a email verification. Please open it to verify your account."),
          const Text(
              "If you haven't received a verification email yet, press the button below."),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send email verification')),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                await Get.offNamedUntil(Routes.registerRoute, (route) => false);
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
