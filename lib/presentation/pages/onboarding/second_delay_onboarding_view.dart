import 'package:fambridge/model/group.dart';
import 'package:fambridge/presentation/component/button/copybutton.dart';
import 'package:fambridge/presentation/component/button/sharebutton.dart';
import 'package:fambridge/presentation/pages/onboarding/check_myself_view.dart';
import 'package:fambridge/presentation/resources/font_manager.dart';
import 'package:fambridge/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fambridge/presentation/resources/color_manager.dart';
import 'package:fambridge/presentation/resources/styles_manager.dart';
import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../model/auth_user.dart';

class second_delayView extends StatefulWidget {
  const second_delayView({super.key});

  @override
  _second_delayState createState() => _second_delayState();
}

class _second_delayState extends State<second_delayView> {

  
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 2), () {
    //   Get.offAllNamed(Routes.buildPages);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final Group group = Get.arguments;
    //가족코드 생성
    String idController = group.groupJoinCode;
    //todo: update family group code
    return Scaffold(
      appBar: onboardingLogoutAppBar(),
      body: Container(
        color: ColorManager.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Fambridge",
                style: getMediumStyle(
                    color: ColorManager.buttonDisable, fontSize: 20),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "'우리'라는 이름 아래 모인 우리 ",
                style:
                    getMediumStyle(color: ColorManager.darkGrey, fontSize: 16),
              ),
              const SizedBox(height: 140),
              const Text("지금까지 들어온 가족 명단"),
              const SizedBox(
                height: 10,
              ),
              Text("${group.userIdsInGroup.length} / ${group.totalNumOfFamilyMember}"),
              const SizedBox(height: 10),
              FamilyList(group: group),
              const SizedBox(
                height: 110,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "가족 코드",
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.darkGrey,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  FittedBox(
                    child: Text(
                          idController,
                          textAlign: TextAlign.center,
                          style: getMediumStyle(
                            color: ColorManager.darkGrey,
                            fontSize: FontSize.s20,
                          ),
                        ),
                  ),
                    
                  
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CopyButton(data: idController),
                  Sharebutton(data: idController),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FamilyList extends StatelessWidget {
  final Group group;
  const FamilyList({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AuthUser>>(
      future: AuthService.firebase().getUserInfos(userIds: group.userIdsInGroup),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.done:
            final users = snapshot.data;
            if(users == null){
              return const Text("no user data");
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: users
                    .map(
                      (AuthUser user) => FamilyMember(
                        name: user.name ?? "no name",
                        type: user.familyRole ?? "no role",
                      ),
                    )
                    .toList(),
            );
          default:
            return const CircularProgressIndicator();
        }
        
      }
    );
  }
}

class FamilyMember extends StatelessWidget {
  final String type;
  final String name;
  const FamilyMember({
    required this.type,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        // CircleProfile(size: 44, profile: profile),
        const SizedBox(
          height: 5,
        ),
        Text(
          type,
          style: getMediumStyle(
            color: ColorManager.darkGrey,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

PreferredSizeWidget _MypageAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      title: Text(
        "",
        style: getMediumStyle(
          fontSize: 18,
          color: ColorManager.darkGrey,
        ),
      ),
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
      elevation: 0.0,
    ),
  );
}

class CircleProfile extends StatelessWidget {
  double size;
  String profile;
  CircleProfile({
    Key? key,
    required this.profile,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: CircleAvatar(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: SvgPicture.asset(
              profile,
              height: size,
              width: size,
              allowDrawingOutsideViewBox: true,
            ),
          ),
        ));
  }
}
