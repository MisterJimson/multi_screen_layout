import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:multi_screen_layout_example/main.dart';

class SurfaceDuoInfoPage extends StatelessWidget {
  const SurfaceDuoInfoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surface Duo Info'),
      ),
      body: MultiScreenInfo(
        builder: (info) {
          return TwoPageLayout(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('The below information is from the Surface Duo SDK'),
                  Text(
                      'isDualScreenDevice: ${info.surfaceDuoInfoModel.isDualScreenDevice}'),
                  Text('isAppSpanned: ${info.surfaceDuoInfoModel.isSpanned}'),
                  Text('hingeAngle: ${info.surfaceDuoInfoModel.hingeAngle}'),
                ],
              ),
            ),
            secondChild: SecondPage(
              showAppBar: false,
            ),
          );
        },
      ),
    );
  }
}
