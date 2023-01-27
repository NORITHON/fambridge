import 'package:fambridge/presentation/common/custom_textfield.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/getx_routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Loginbody(),
            LoginBottom(),
          ],
        ),
      ),
    );
  }
}

class Loginbody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorManager.primary,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.13,
              color: Color(0xffFF0000).withOpacity(0.2),
            ),
            LoginForm(),
            Container(
              width: MediaQuery.of(context).size.width * 0.13,
              color: Color(0xffFF0000).withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String id = "";
  String password = "";

  _LoginFormState() {
    idController.addListener(() {
      setState(
        () {
          id = idController.text;
        },
      );
    });
    passwordController.addListener(() {
      setState(
        () {
          password = passwordController.text;
        },
      );
    });
  }

  var textStyle = TextStyle(
    fontFamily: 'GmarketSans',
  );
  var pointStyle = TextStyle(
    color: ColorManager.orange,
    fontFamily: 'GmarketSans',
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Container(
              width: 150,
              height: 150,
              color: Colors.black,
            ),
            SizedBox(height: 30),
            Text(
              "로그인",
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            SizedBox(height: 15),
            CustomTextfield(hintText: "아이디", controller: idController),
            SizedBox(
              height: 8,
            ),
            CustomTextfield(hintText: "비밀번호", controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.forgotIdRoute);
                  },
                  child: Text(
                    "아이디",
                    style: pointStyle,
                  ),
                ),
                Text(
                  "/",
                  style: pointStyle,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.forgotIdRoute);
                  },
                  child: Text(
                    "비밀번호 찾기",
                    style: pointStyle,
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.orange,
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  print("id");
                  print(id);
                  print("password");
                  print(password);
                  return;
                },
                child: Text(
                  "로그인",
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("처음이세요?"),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.registerRoute),
                  child: Text(
                    "회원가입하기",
                    style: pointStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.13,
            height: 50,
            color: Color(0xffFF9B92),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.13,
              height: 50,
              color: Color(0xffFF0000).withOpacity(0.2),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.13,
            height: 50,
            color: Color(0xffFF9B92),
          ),
        ],
      ),
    );
  }
}
