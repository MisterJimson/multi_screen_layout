import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

class MasterDetailLayout extends StatelessWidget {
  final Widget master;
  final Widget detail;
  final bool isSelected;

  const MasterDetailLayout({
    Key key,
    this.master,
    this.detail,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
        return Navigator(
          onPopPage: (route, result) => route.didPop(result),
          pages: [
            MaterialPage(
              key: Key('master'),
              builder: (context) {
                return TwoPageLayout(
                  child: master,
                  secondChild: detail,
                );
              },
            ),
            if (!info.isSpanned && isSelected)
              MaterialPage(
                key: Key('detail'),
                builder: (context) {
                  return detail;
                },
              ),
          ],
        );
      },
    );
  }
}
