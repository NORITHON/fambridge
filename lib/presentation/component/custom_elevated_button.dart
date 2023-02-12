import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final double width;
  final TextEditingController? id;
  final TextEditingController? password;
  final VoidCallback onpress;

  LoginButton({
    super.key,
    this.id,
    this.password,
    required this.width,
    required this.onpress,
  });

  var textStyle = const TextStyle(
    fontFamily: 'GmarketSans',
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
