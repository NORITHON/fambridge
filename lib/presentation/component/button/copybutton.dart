import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String data;

  const CopyButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 147,
          height: 57,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.point,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              // 데이터 값을 처리하거나 다른 페이지로 전달할 수 있음
              Clipboard.setData(ClipboardData(text: data));
              print(data);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("복사 되었습니다! $data"),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                ),
              );
            },
            child: Text(
              "복사하기",
              style: getRegularStyle(color: ColorManager.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
