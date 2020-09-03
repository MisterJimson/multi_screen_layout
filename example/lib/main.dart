import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TwoPageLayout(
      child: _buildMainPage(),
      secondChild: _buildSecondPage(),
    );
  }

  Widget _buildMainPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: MultiScreenInfo(
          builder: (info) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('This page always displays!'),
                Text(
                    'isDualScreenDevice: ${info.surfaceDuoInfoModel.isDualScreenDevice}'),
                Text('isAppSpanned: ${info.surfaceDuoInfoModel.isSpanned}'),
                Text('hingeAngle: ${info.surfaceDuoInfoModel.hingeAngle}'),
                RaisedButton(
                  child: Text('Test'),
                  onPressed: () {
                    MultiScreenPlatformHandler.getInfoModel();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSecondPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('This page only shows when spanned on 2 screens!'),
          ],
        ),
      ),
    );
  }
}
