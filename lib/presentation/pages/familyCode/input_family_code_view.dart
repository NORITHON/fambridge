import 'dart:developer';

import 'package:fambridge/app/app.dart';
import 'package:fambridge/app/constants/enums/family_role.dart';
import 'package:fambridge/model/group.dart';
import 'package:fambridge/presentation/component/widgets/input_code_field.dart';
import 'package:fambridge/presentation/pages/onboarding/check_myself_view.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/utilities/loading_dialog.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:fambridge/service/crud/group_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class InputFamilyCode extends StatefulWidget {
  const InputFamilyCode({Key? key}) : super(key: key);

  @override
  _InputFamilyCodeState createState() => _InputFamilyCodeState();
}

class _InputFamilyCodeState extends State<InputFamilyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onboardingLogoutAppBar(),
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
            "?????? ????????? ???????????????.",
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
                hintText: "?????? ?????? ?????? ??????", controller: codeController),
          ),
          const SizedBox(height: 150),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '?????? ???????????????',
                style:
                    getRegularStyle(color: ColorManager.darkGrey, fontSize: 14),
              ),
              SizedBox(
                width: 160,
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
                    try {
                      final user = await AuthService.firebase().currentUser;
                      GroupStateProvider().newGroupInfo[GroupFirestoreFieldName
                          .familyGroupCodeFieldname] = const Uuid().v4();
                      GroupStateProvider().newGroupInfo[GroupFirestoreFieldName
                          .groupIdFieldName] = const Uuid().v4();
                      GroupStateProvider().newGroupInfo[
                          GroupFirestoreFieldName.groupNameFieldName] = "group";
                      GroupStateProvider().newGroupInfo[GroupFirestoreFieldName
                          .joinedUserIdsFieldName] = [user!.id];
                      GroupStateProvider().newGroupInfo[GroupFirestoreFieldName
                          .totalNumOfFamilyMemberFieldName] = 5;
                      GroupStateProvider().newGroupInfo[
                          GroupFirestoreFieldName.treeXpFieldName] = 0;
                      final group =
                          await GroupService.firebase().createNewGroup();
                      await AuthService.firebase().addAuthToDatabase(
                          authUser: user,
                          name: "shinhoo",
                          familyRole: FamilyRole.son,
                          birthOrder: 1,
                          groupId: group.familyGroupId);
                      MyApp.unsyncronizedAuthUser =
                          await AuthService.firebase().currentUser;
                    } catch (e) {
                      log(e.toString());
                    }
                    Get.back();
                    Get.toNamed(Routes.firstDelayRoute);
                  },
                  child: Text(
                    "?????? ??????",
                    style: getRegularStyle(
                      color: ColorManager.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
