import 'package:flutter/widgets.dart';
import 'package:multi_screen_layout/src/models.dart';
import 'package:multi_screen_layout/src/platform_handler.dart';

/// A Builder widget that provides multi screen information about the device
class MultiScreenInfo extends StatefulWidget {
  final Widget Function(MultiScreenLayoutInfoModel info) builder;

  const MultiScreenInfo({
    required this.builder,
  }) : super(key: const PageStorageKey('MultiScreenInfo'));

  @override
  _MultiScreenInfoState createState() => _MultiScreenInfoState();
}

class _MultiScreenInfoState extends State<MultiScreenInfo>
    with WidgetsBindingObserver {
  MultiScreenLayoutInfoModel info = MultiScreenLayoutInfoModel.unknown();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    info = (PageStorage.of(context)?.readState(
          context,
          identifier: 'MultiScreenInfo',
        ) as MultiScreenLayoutInfoModel?) ??
        MultiScreenLayoutInfoModel.unknown();
    updateInfo();
  }

  @override
  void didChangeMetrics() {
    updateInfo();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DevicePosture>(
      stream: MultiScreenPlatformHandler.onDevicePostureChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          info = info.copyWith(posture: snapshot.data);
        }
        return widget.builder(info);
      },
    );
  }

  Future updateInfo() async {
    if (mounted) {
      var _info = await MultiScreenPlatformHandler.getInfoModel();
      if (mounted) {
        PageStorage.of(context)?.writeState(
          context,
          _info,
          identifier: 'MultiScreenInfo',
        );
        setState(() {
          info = _info;
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
