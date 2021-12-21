import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:multi_screen_layout_example/android_device_posture_info_page.dart';
import 'package:multi_screen_layout_example/master_detail_layout_example.dart';
import 'package:multi_screen_layout_example/surface_duo_hinge_angle_example.dart';
import 'package:multi_screen_layout_example/surface_duo_info_page.dart';
import 'package:multi_screen_layout_example/two_page_layout_example.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TwoPageLayout(
      child: MainPage(),
      secondChild: SecondPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('This page always displays!'),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Two Page Layout Example'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TwoPageLayoutExample()));
                  },
                ),
                ListTile(
                  title: Text('Master Detail Layout Example'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MasterDetailLayoutExample()));
                  },
                ),
                ListTile(
                  title: Text('Android Device Posture Info'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AndroidDevicePostureInfoPage()));
                  },
                ),
                ListTile(
                  title: Text('Surface Duo Device Info'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SurfaceDuoInfoPage()));
                  },
                ),
                ListTile(
                  title: Text('Surface Duo Hinge Angle'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SurfaceDuoHingeAngle()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final bool showAppBar;

  const SecondPage({
    Key key,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text('Second Page'),
            )
          : null,
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Hello from page 2! This only displays when spanned across 2 '
                'displays or the device posture is half opened. Also known as '
                'Samsung\'s Flex Mode.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
