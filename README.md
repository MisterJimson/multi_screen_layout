# Multi Screen Layout for Flutter
[![pub package](https://img.shields.io/pub/v/multi_screen_layout.svg?label=multi_screen_layout&color=blue)](https://pub.dev/packages/multi_screen_layout)

A collection of Widgets that make multi screen user experiences easy to build
## Supported Devices
- [x] Surface Duo
- [ ] Galaxy Z Fold
- [ ] Galaxy Z Flip

If you know of other devices that could support multi screen layouts, please submit a PR and add them to this list.
## Layouts
### TwoPageLayout
Displays two Widgets, one per screen, on a dual screen device when the app is being spanned across both screens. This is designed to be used to accomplish Two Page, Dual View, and Companion Pane [dual screen app patterns](https://docs.microsoft.com/en-us/dual-screen/introduction#dual-screen-app-patterns).

On a non multi screen device, or when the app is only running on a single screen, only the first page will display.

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
![Two Page 1](/.media/two_page_1.png?raw=true)

![Two Page 2](/.media/two_page_2.png?raw=true)
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
