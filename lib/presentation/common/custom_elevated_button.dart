import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class CustumButton extends StatelessWidget {
  double width;
  TextEditingController? id;
  TextEditingController? password;
  VoidCallback onpress;

  CustumButton({
    super.key,
    this.id,
    this.password,
    required this.width,
    required this.onpress,
  });

  var textStyle = TextStyle(
    fontFamily: 'GmarketSans',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // print(idController.value);
          // print(passwordController.value);
          return;
        },
        child: Text(
          "로그인",
          style: textStyle,
        ),
      ),
    );
  }
}
