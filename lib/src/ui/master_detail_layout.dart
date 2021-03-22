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

  /// Allows you to disable the two page layout behavior for specific types of
  /// multi screen devices
  final List<MultiScreenType> disableFor;

  const MasterDetailLayout({
    Key? key,
    required this.master,
    required this.detail,
    required this.isSelected,
    this.disableFor = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
        var displaySecondPageForAndroidStandard =
            info.posture == DevicePosture.halfOpened &&
                !disableFor.contains(MultiScreenType.androidStandard);
        var displaySecondPageForSurfaceDuo =
            info.surfaceDuoInfoModel.isSpanned &&
                !disableFor.contains(MultiScreenType.surfaceDuo);

        return Navigator(
          onPopPage: (route, result) {
            if (route.isFirst) Navigator.maybePop(context);
            var did = route.didPop(result);
            return did;
          },
          pages: [
            MaterialPage(
              key: Key('master') as LocalKey?,
              child: TwoPageLayout(
                child: master,
                secondChild: detail,
              ),
            ),
            if (!(displaySecondPageForAndroidStandard ||
                    displaySecondPageForSurfaceDuo) &&
                isSelected)
              MaterialPage(
                key: Key('detail') as LocalKey?,
                child: detail,
              ),
          ],
        );
      },
    );
  }
}
