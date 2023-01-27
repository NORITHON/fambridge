import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("RegisterView"),
              ElevatedButton.icon(
                onPressed: () {
                  Get.offNamed(Routes.loginRoute);
                },
                icon: const Icon(Icons.login),
                label: const Text("Go to Login"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.defaultDialog(
                    title: "회원가입이 완료되었습니다.",
                    middleText: "회원가입이 완료되었습니다.",
                    cancel: TextButton(
                      onPressed: () => Get.offNamed(Routes.loginRoute),
                      child: Text("확인"),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
