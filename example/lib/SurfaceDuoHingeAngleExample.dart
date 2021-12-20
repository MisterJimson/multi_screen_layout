import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:multi_screen_layout_example/main.dart';

class SurfaceDuoHingeAngle extends StatelessWidget {
  const SurfaceDuoHingeAngle();

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
        return Opacity(
          opacity: (min(info.surfaceDuoInfoModel.hingeAngle, 180) / 180),
          child: Scaffold(
            appBar: AppBar(title: const Text('Surface Duo Hinge Angle')),
            body: TwoPageLayout(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'The hinge angle should display below and update in real'
                        ' time. The opacity of this widget is linked to the '
                        'angle, as you close the device the screen should darken.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '${info.surfaceDuoInfoModel.hingeAngle}',
                      style: TextStyle(fontSize: 36),
                    ),
                  ],
                ),
              ),
              secondChild: SecondPage(
                showAppBar: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
