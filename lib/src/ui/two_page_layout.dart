import 'package:flutter/material.dart';
import 'package:multi_screen_layout/src/ui/multi_screen_info.dart';

/// Always displays [child], [secondChild] is displayed if the app is spanned
/// across 2 displays.
///
/// Relevant Microsoft layout documentation:
/// Two Page: https://docs.microsoft.com/en-us/dual-screen/introduction#two-page
/// Dual View: https://docs.microsoft.com/en-us/dual-screen/introduction#dual-view
/// Companion Pane: https://docs.microsoft.com/en-us/dual-screen/introduction#companion-pane
class TwoPageLayout extends StatelessWidget {
  final Widget child;
  final Widget secondChild;

  const TwoPageLayout({
    Key key,
    this.child,
    this.secondChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
        if (!info.surfaceDuoInfoModel.isSpanned) {
          return child;
        }
        return Row(
          children: <Widget>[
            Expanded(child: child),
            SizedBox(width: info.surfaceDuoInfoModel.seemThickness),
            Expanded(child: secondChild),
          ],
        );
      },
    );
  }
}
