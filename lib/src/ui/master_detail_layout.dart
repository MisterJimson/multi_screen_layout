import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

/// Very similar to [TwoPageLayout]. This layout has better support for having
/// related, "deeper", content in the second page that would usually be accessed
/// by navigating to a new page.
///
/// It's common to use this type of layout when you have a list of items that
/// when tapped let you view a detailed view of the item. Email and instant
/// messaging apps are examples of this.
///
/// On a single screen device, or when the app is only running on a single
/// screen, [master] will display first. When [isSelected] is true, [detail] is
/// displayed as a new page on top of [master], similar to using `Navigator.push`.
///
/// When spanned across 2 screens, both [master] and [detail] display at the
/// same time and no navigation occurs. Even when [isSelected] is false.
///
/// `MasterDetailLayout` also handles switching between spanned and non-spanned
/// modes appropriately, so the UI will be the same if you select and then span,
/// or span and then select.
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
