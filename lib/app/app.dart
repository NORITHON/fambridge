import 'package:fambridge/model/auth_user.dart';
import 'package:fambridge/presentation/resources/getx_routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'constants/app_state_fieldname/auth_state.dart';
import 'constants/app_state_fieldname/group_state.dart';
import 'constants/app_state_fieldname/question_state.dart';

@immutable
class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  static final Map<String, Map<String, dynamic>> appState = {
    authStateFieldName: {
      hasGroupFieldName: false,
      newUserInputsFieldName: {
        newUserBirthOrderFieldName: null,
        newUserFamilyRoleFieldName: null,
        newUserNameFieldName: null,
      }
    },
    groupStateFieldName: {
      groupFieldName: null,
      newGroupInputsFieldName: {
        newGroupNameFieldName: null,
        newGroupNumOfMemberFieldName: null,
      }
    },
    questionStateFieldName: {
      userAnswerTextInputFieldName: "",
    }
  };
  static AuthUser? unsyncronizedAuthUser;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      title: 'fambridge',
      initialRoute: Routes.loginRoute,
      getPages: getPages,
    );
  }
}
