import 'dart:developer';

import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../app/app.dart';
import '../../../model/group.dart';
import '../../../service/auth/auth_service.dart';
import '../../../service/crud/group_service.dart';
import '../../../service/crud/group_state_provider.dart';
import '../../utilities/loading_dialog.dart';

class ButtonCheck extends StatelessWidget {
  const ButtonCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 240,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.point,
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () async {
              loadingDialog(context);
              final user = await AuthService.firebase().currentUser;

              // 그룹 코드 발급 -> 그룹이 없는 것이므로 새로운 그룹을 생성한다.
              // 그룹 [코드] 초기값 설정
              GroupStateProvider().newGroupInfo[GroupFirestoreFieldName
                  .familyGroupCodeFieldname] = const Uuid().v4();

              // 그룹 [아이디] 초기값 설정
              GroupStateProvider()
                      .newGroupInfo[GroupFirestoreFieldName.groupIdFieldName] =
                  const Uuid().v4();

              // 그룹 [이름] 초기값 설정
              GroupStateProvider().newGroupInfo[
                  GroupFirestoreFieldName.groupNameFieldName] = "group";

              // 그룹 [treeXp] 초기값 설정
              GroupStateProvider()
                  .newGroupInfo[GroupFirestoreFieldName.treeXpFieldName] = 0;

              // 그룹 [유저아이디] 설정
              GroupStateProvider().newGroupInfo[
                  GroupFirestoreFieldName.joinedUserIdsFieldName] = [user!.id];

              try {
                //새로운 그룹 생성하기
                final group = await GroupService.firebase().createNewGroup();

                //새로운 유저 생성하기
                await AuthService.firebase().addAuthToDatabase(
                  authUser: user,
                  name: user.name ?? "no name",
                  familyRole: GroupStateProvider()
                      .newGroupInfo[GroupFirestoreFieldName.myRoleFieldName],
                  birthOrder: 1,
                  groupId: group.familyGroupId,
                );   
              } catch (e) {
                log(e.toString());
                Get.back();
                return;
              }

              // myapp으로 유저데이터 가져오기?
              MyApp.unsyncronizedAuthUser =
                  await AuthService.firebase().currentUser;

              Get.back();
              // for test
              Get.toNamed(Routes.homeRoute);
              //가족이 다 모였다면
              //Get.toNamed(Routes.secondDelayRoute);
              //아직 다 모이지 않았다면
              //Get.toNamed(Routes.codeshareRoute);
            },
            child: Text(
              "그룹 생성 완료하기",
              style: getRegularStyle(color: ColorManager.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
