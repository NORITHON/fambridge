import 'package:fambridge/presentation/common/custom_textfield.dart';
import 'package:fambridge/presentation/familyCode/widget/input_code_field.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/enums/family_role.dart';
import '../../service/auth/auth_service.dart';
import '../../service/group/group_service.dart';
import '../../service/question/question_service.dart';
import '../utilities/loading_dialog.dart';

class InputFamilyCode extends StatefulWidget {
  const InputFamilyCode({Key? key}) : super(key: key);

  @override
  _InputFamilyCodeState createState() => _InputFamilyCodeState();
}

class _InputFamilyCodeState extends State<InputFamilyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: InputFamilybody(),
      ),
    );
  }

  PreferredSizeWidget _AppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            ImageAssets.back,
            height: 20,
            width: 20,
            fit: BoxFit.scaleDown,
          ),
        ),
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Row(
            children: const [
              FamilyCodeForm(),
            ],
          ),
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
  late final TextEditingController codeController;
  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 230),
          Text(
            "가족 코드를 입력하세요.",
            textAlign: TextAlign.center,
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
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
            child: InputCodeTextField(
                hintText: "공유 받은 코드 입력", controller: codeController),
          ),
          const SizedBox(height: 150),
          Text(
            "제가 시작하는 사람이에요!",
            textAlign: TextAlign.center,
            style: getMediumStyle(
              color: ColorManager.darkGrey,
              fontSize: 16,
            ),
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
              onPressed: () async {
                loadingDialog(context);
                final user = await AuthService.firebase().currentUser;
                final question =
                    await QuestionService.firebase().getNextQuestion();
                final group = await GroupService.firebase().createNewGroup(
                    groupName: "groupName",
                    creatorUserId: user!.id,
                    question: question,
                    );
                await AuthService.firebase().addAuthToDatabase(
                    name: "shinhoo",
                    familyRole: FamilyRole.son,
                    birthOrder: 1,
                    groupId: group.groupId);
                AuthService.nonSyncronizedUser =
                    await AuthService.firebase().currentUser;
                Get.back();
                Get.toNamed(Routes.firstDelayRoute);
              },
              child: Text(
                "새로운 코드 받기",
                style: getMediumStyle(
                  color: ColorManager.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
