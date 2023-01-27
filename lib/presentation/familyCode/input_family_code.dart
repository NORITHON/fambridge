import 'package:fambridge/presentation/common/custom_textfield.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/getx_routes_manager.dart';

class InputFamilyCode extends StatefulWidget {
  const InputFamilyCode({Key? key}) : super(key: key);

  @override
  _InputFamilyCodeState createState() => _InputFamilyCodeState();
}

class _InputFamilyCodeState extends State<InputFamilyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: InputFamilybody(),
      ),
    );
  }
}

class InputFamilybody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorManager.backgroundColor,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.13,
              color: Color(0xffFF0000).withOpacity(0.2),
            ),
            FamilyCodeForm(),
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

class FamilyCodeForm extends StatefulWidget {
  const FamilyCodeForm({super.key});

  @override
  State<FamilyCodeForm> createState() => _FamilyCodeFormState();
}

class _FamilyCodeFormState extends State<FamilyCodeForm> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String id = "";
  String password = "";

  _FamilyCodeFormState() {
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
    fontSize: 16,
  );
  var pointStyle = TextStyle(
    color: ColorManager.point,
    fontFamily: 'GmarketSans',
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 230),
            Text(
              "가족 코드를 입력하세요.",
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 0), // changes position of shadow
                  )
                ],
              ),
              child: CustomTextfield(
                  hintText: "공유 받은 코드 입력", controller: idController),
            ),
            SizedBox(height: 200),
            Text(
              "제가 시작하는 사람이에요!",
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            SizedBox(height: 7),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.point,
                  padding: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  return;
                },
                child: Text(
                  "새로운 코드 받기",
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
