import 'package:multi_screen_layout/src/devices/android_generic.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';

/// Contains all multi screen data our widgets need to layout
class MultiScreenLayoutInfoModel {
  final DevicePosture posture;
  final SurfaceDuoInfoModel surfaceDuoInfoModel;

  MultiScreenLayoutInfoModel({
    this.posture,
    this.surfaceDuoInfoModel,
  });

  factory MultiScreenLayoutInfoModel.fromPlatform(PlatformInfoModel info) =>
      MultiScreenLayoutInfoModel(
        posture: _fromInt(info.devicePosture),
        surfaceDuoInfoModel:
            info.surfaceDuoInfoModel ?? SurfaceDuoInfoModel.unknown(),
      );

  factory MultiScreenLayoutInfoModel.unknown() => MultiScreenLayoutInfoModel(
        surfaceDuoInfoModel: SurfaceDuoInfoModel.unknown(),
      );
}

enum DevicePosture {
  closed,
  flipped,
  halfOpened,
  opened,
  unknown,
}

DevicePosture _fromInt(int value) {
  if (value == null) return DevicePosture.unknown;

  switch (value) {
    case 1:
      return DevicePosture.closed;
    case 4:
      return DevicePosture.flipped;
    case 2:
      return DevicePosture.halfOpened;
    case 3:
      return DevicePosture.opened;
    default:
      return DevicePosture.unknown;
  }
}

enum MultiScreenType {
  Generic,
  SurfaceDuo,
}
