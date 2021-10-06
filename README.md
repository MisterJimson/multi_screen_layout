# Multi Screen Layout for Flutter
[![pub package](https://img.shields.io/pub/v/multi_screen_layout.svg?label=multi_screen_layout&color=blue)](https://pub.dev/packages/multi_screen_layout)

A collection of Widgets that make multi screen user experiences easy to build
## Supported Devices
- [x] Surface Duo
- [x] Galaxy Z Fold 1 (Flex Mode)
- [x] Galaxy Z Fold 2 (Flex Mode)
- [x] Galaxy Z Fold 3 (Flex Mode)
- [x] Galaxy Z Flip (Flex Mode)
- [ ] LG Wing

If you know of other devices that could support multi screen layouts, please submit a PR and add them to this list.
## Layouts
### TwoPageLayout
Displays two Widgets, one per screen. 

On a dual screen device when the app is being spanned across two screens, displays both widgets, one per screen. This is designed to be used to accomplish Two Page, Dual View, and Companion Pane [dual screen app patterns from Microsoft](https://docs.microsoft.com/en-us/dual-screen/introduction#dual-screen-app-patterns).

On a folding screen device when the screen is half opened the screen is treated as a dual screen device. This is designed to be used to Accomplish [Flex Mode](https://developer.samsung.com/galaxy-z/flex-mode.html) user experiences.

On a single screen device, or when the app is only running on a single screen, only `child` will be displayed.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TwoPageLayout(
      child: Scaffold(body: Center(child: Text('Hello from page 1!'))),
      secondChild: Scaffold(body: Center(child: Text('Hello from page 2!'))),
    );
  }
}
```
#### Surface Duo Example
![Two Page 1](https://raw.githubusercontent.com/MisterJimson/multi_screen_layout/main/.media/two_page_1.png)

![Two Page 2](https://raw.githubusercontent.com/MisterJimson/multi_screen_layout/main/.media/two_page_2.png)
#### Samsung Z Fold 2 Flex Mode Example
[See video here](https://i.imgur.com/I6lAkYF.mp4)
### MasterDetailLayout
Very similar to `TwoPageLayout`. This layout has better support for having related, "deeper", content in the second page that would usually be accessed by navigating to a new page.

It's common to use this type of layout when you have a list of items that when tapped let you view a detailed view of the item. Email and instant messaging apps are good examples of this.

On a single screen device, or when the app is only running on a single screen, `master` will display first. When `isSelected` is true, `detail` is displayed as a new page on top of `master`, similar to using `Navigator.push`.

When displaying on 2 screens, both `master` and `detail` display at the same time and no navigation occurs. Even when `isSelected` is false. 

Similar to `TwoPageLayout`, on a folding screen device when the screen is half opened the screen is treated as a dual screen device.

`MasterDetailLayout` also handles switching between spanned and non-spanned modes appropriately, so the UI will be the same if you select and then span, or span and then select.
 
```dart
class MasterDetailLayoutExample extends StatefulWidget {
  @override
  _MasterDetailLayoutExampleState createState() =>
      _MasterDetailLayoutExampleState();
}

class _MasterDetailLayoutExampleState extends State<MasterDetailLayoutExample> {
  int selectedItem;

  @override
  Widget build(BuildContext context) {
    return MasterDetailLayout(
      master: EmailList(onItemSelected: (selected) {
        setState(() {
          selectedItem = selected;
        });
      }),
      detail: EmailDetail(itemNumber: selectedItem),
      isSelected: selectedItem != null,
    );
  }
}
```
#### Surface Duo Example
![MasterDetail](https://raw.githubusercontent.com/MisterJimson/multi_screen_layout/main/.media/master_detail.gif)
#### Samsung Z Fold 2 Flex Mode Example
[See video here](https://i.imgur.com/dHFlvMx.mp4)
## Direct Data Access
Direct access is for advanced uses cases. The above layouts should be suitable for most apps.

There may be cases where you want to access multi screen information instead of just using the above layout widgets. Here is how to do that.
### MultiScreenInfo
`MultiScreenInfo` is a Widget that lets you access information about the device directly in your Widget tree, it will rebuild when the data changes.
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiScreenInfo(
        builder: (info) {
          return Column(
            children: <Widget>[
              Text('The below information is from the Surface Duo SDK'),
              Text('isAppSpanned: ${info.surfaceDuoInfoModel.isSpanned}'),
              Text('hingeAngle: ${info.surfaceDuoInfoModel.hingeAngle}'),
            ],
          );
        },
      ),
    );
  }
}
```
### PlatformHandlers
If you need access to information about the device outside of the Widget tree, you can also make platform calls yourself.
#### SurfaceDuoPlatformHandler
```dart
Future getSurfaceDuoInfo() async {
    var hingeAngle = await SurfaceDuoPlatformHandler.getHingeAngle();
    var isDual = await SurfaceDuoPlatformHandler.getIsDual();
    var isSpanned = await SurfaceDuoPlatformHandler.getIsSpanned();
    var nonFunctionalBounds = await SurfaceDuoPlatformHandler.getNonFunctionalBounds();
  }
```

## Extra Documentation
- [Microsoft Dual Screen](https://docs.microsoft.com/en-us/dual-screen/introduction)
- [Samsung Flex Mode](https://developer.samsung.com/galaxy-z/flex-mode.html)
- [Android Window DeviceState](https://developer.android.com/reference/androidx/window/DeviceState)
