import 'package:fambridge/presentation/common/custom_textfield.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class InputFamilyCode extends StatefulWidget {
  const InputFamilyCode({Key? key}) : super(key: key);

  @override
  _InputFamilyCodeState createState() => _InputFamilyCodeState();
}

class _InputFamilyCodeState extends State<InputFamilyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Next page',
            onPressed: () {},
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: InputFamilybody(),
      ),
    );
  }
}

class InputFamilybody extends StatelessWidget {
  const InputFamilybody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ColorManager.backgroundColor,
        child: Row(
          children: const [
            FamilyCodeForm(),
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

  var textStyle = const TextStyle(
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
            const SizedBox(height: 230),
            Text(
              "가족 코드를 입력하세요.",
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 0), // changes position of shadow
                  )
                ],
              ),
              child: CustomTextfield(
                  hintText: "공유 받은 코드 입력", controller: idController),
            ),
            const SizedBox(height: 200),
            Text(
              "제가 시작하는 사람이에요!",
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            const SizedBox(height: 7),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.point,
                  padding: const EdgeInsets.all(12),
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
