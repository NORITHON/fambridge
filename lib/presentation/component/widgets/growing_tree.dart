import 'dart:developer';

import 'package:fambridge/model/group.dart';
import 'package:fambridge/service/crud/group_service.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

class GrowingTree extends StatefulWidget {
  const GrowingTree({
    Key? key,
    required this.group,
  }) : super(key: key);

  final Group group;

  @override
  State<GrowingTree> createState() => _GrowingTreeState();
}

class _GrowingTreeState extends State<GrowingTree> {
  bool get isPlaying => _controller?.isActive ?? false;

  rive.Artboard? _riveArtboard;
  rive.StateMachineController? _controller;
  rive.SMIInput<double>? _input;

  @override
  void initState() {
    super.initState();

    rootBundle.load(RiveAssets.growingThree).then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = rive.RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller =
            rive.StateMachineController.fromArtboard(artboard, 'GrowingTree');
        if (controller != null) {
          artboard.addController(controller);
          _input = controller.findInput('xpForTree');
        }
        _input!.value = widget.group.treeXp.toDouble();
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _input?.value = widget.group.treeXp.toDouble();
    return Expanded(
      child: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onVerticalDragEnd: (details) async {
                      log(details.velocity.pixelsPerSecond.toString());
                      final int setVal;
                      if (details.velocity.pixelsPerSecond.dy > 500) {
                        setVal = -1;
                      } else if (details.velocity.pixelsPerSecond.dy < -500) {
                        setVal = 1;
                      } else {
                        setVal = 0;
                      }
                      if (setVal != 0) {
                        await GroupService.firebase()
                            .setTreeXp(group: widget.group, setVal: setVal);
                      }
                    },
                    child: SizedBox(
                      width: 300.0,
                      height: 210,
                      child: rive.Rive(
                        artboard: _riveArtboard!,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
