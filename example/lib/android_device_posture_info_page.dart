import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:multi_screen_layout_example/main.dart';

class AndroidDevicePostureInfoPage extends StatelessWidget {
  const AndroidDevicePostureInfoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Android Device Posture Info'),
      ),
      body: MultiScreenInfo(
        builder: (info) {
          return TwoPageLayout(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'The below information is from the Jetpack Window Manager library',
                    textAlign: TextAlign.center,
                  ),
                  Text('Posture: ${info.posture.toString()}'),
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
