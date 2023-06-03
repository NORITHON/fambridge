import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../app/constants/enums/request_action.dart';
import '../../component/button/request_button.dart';
import '../../component/widgets/app_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late final TextEditingController _wordNameTextEditingController;
  late final TextEditingController _requestTextEditingController;

  @override
  void initState() {
    _wordNameTextEditingController = TextEditingController();
    _requestTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _wordNameTextEditingController.dispose();
    _requestTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: mypageAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    '서비스 피드백',
                    style: getBoldStyle(color: ColorManager.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 600,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '요청 제목',
                        style: getRegularStyle(color: ColorManager.black),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _wordNameTextEditingController,
                        decoration:  const InputDecoration(hintText: '제목을 입력해주세요.'),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 36),
                      Text(
                        '내용',
                        style: getRegularStyle(color: ColorManager.black),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller:  _requestTextEditingController,
                        decoration:  const InputDecoration(hintText: '내용을 입력해주세요.'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 91,
                height: 48,
                child: RequestButton(
                  snackBarText: '피드백이 정상적으로 제출되었습니다.',
                  requestAction: RequestAction.addRequest,
                  wordTextEditingController: _wordNameTextEditingController,
                  requestContentTextEditingController: _requestTextEditingController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
