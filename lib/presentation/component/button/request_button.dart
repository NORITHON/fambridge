import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';

import '../../../app/constants/enums/request_action.dart';
import '../bar/my_snackbar.dart';

class RequestButton extends StatelessWidget {
  const RequestButton({
    Key? key,
    required this.snackBarText,
    required this.requestAction,
    required this.wordTextEditingController,
    required this.requestContentTextEditingController,
  }) : super(key: key);

  final String snackBarText;
  final RequestAction requestAction;
  final TextEditingController wordTextEditingController;
  final TextEditingController requestContentTextEditingController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        switch(requestAction){
          case RequestAction.revisementRequest:
            //FirebaseCloudReviseRequestStorage().createNewReviseRequest(word: wordTextEditingController.text, revisement: requestContentTextEditingController.text, requestId: const Uuid().v4());
            break;
          case RequestAction.addRequest:
            //FirebaseCloudAddRequestStorage().createNewAddRequest(word: wordTextEditingController.text, meaning: requestContentTextEditingController.text, requestId: const Uuid().v4());
            break;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackBar(
            icon: SvgPicture.asset('assets/image/pencil.svg'),
            text: snackBarText,
          ),
        );
        wordTextEditingController.clear();
        requestContentTextEditingController.clear();
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              width: 0,
              color: ColorManager.primary,
            )),
      ),
      child: Text(
        '완료',
        style: getRegularStyle(color: ColorManager.white,),
      ),
    );
  }
}
