import 'package:fambridge/presentation/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class HomeProfile extends StatelessWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAssets.profile);
  }
}
