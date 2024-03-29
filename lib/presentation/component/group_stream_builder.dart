
import 'dart:developer';

import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/material.dart';
import '../../model/group.dart';

class GroupStreamBuilder extends StatelessWidget {
  const GroupStreamBuilder({super.key, required this.builder, required this.groupId});

  final String groupId;
  final Widget Function(BuildContext, Group) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Group>(
        stream: GroupService.firebase().getGroup(groupId: groupId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                return builder(context, snapshot.data!);
              } else {
                return const Scaffold(
                    body: Center(
                  child: Text("cannot find group info"),
                ));
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
