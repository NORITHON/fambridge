import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("우리가 모두 모였습니다."),
              Text(
                "서로 알아가는 시간이 되어 보아요",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
