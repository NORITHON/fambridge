import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;
import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class GrowingTree extends StatefulWidget {
  const GrowingTree({
    Key? key,
  }) : super(key: key);

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
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  _input!.value = _input!.value + 5;
                },
                child: Column(
                  children: [
                    // const SizedBox(height: 10),
                    // Slider(
                    //   value: _input!.value,
                    //   min: 0,
                    //   max: 100,
                    //   thumbColor: ColorManager.point,
                    //   activeColor: ColorManager.point,
                    //   inactiveColor: ColorManager.buttonDisable,
                    //   label: _input!.value.round().toString(),
                    //   onChanged: (double value) => setState(() {
                    //     _input!.value = value;
                    //   }),
                    // ),
                    // const SizedBox(height: 10),
                    Expanded(
                      child: rive.Rive(
                        artboard: _riveArtboard!,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
