import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.login),
              label: const Text("Login continue with google"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(Routes.registerRoute);
              },
              icon: const Icon(Icons.add),
              label: const Text("Go to Register"),
            ),
          ],
        ),
      ),
    );
  }
}
