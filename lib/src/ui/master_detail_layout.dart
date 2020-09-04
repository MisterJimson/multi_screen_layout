import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

class MasterDetailLayout extends StatelessWidget {
  final Widget master;
  final Widget detail;
  final bool isSelected;

  MasterDetailLayout({
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
            CustomBuilderPage(
              key: Key('master'),
              routeBuilder: (context, settings) {
                return MaterialPageRoute(
                  maintainState: false,
                  builder: (_) {
                    return TwoPageLayout(
                      child: master,
                      secondChild: detail,
                    );
                  },
                  settings: settings,
                );
              },
            ),
            if (!info.isSpanned && isSelected)
              CustomBuilderPage(
                key: Key('detail'),
                routeBuilder: (context, settings) {
                  return MaterialPageRoute(
                    builder: (_) {
                      return detail;
                    },
                    settings: settings,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
