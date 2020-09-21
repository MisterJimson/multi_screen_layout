import 'package:multi_screen_layout/src/devices/android_standard.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';

/// Contains all multi screen data our widgets need to layout
class MultiScreenLayoutInfoModel {
  final DevicePosture posture;
  final SurfaceDuoInfoModel surfaceDuoInfoModel;

  MultiScreenLayoutInfoModel({
    this.posture,
    this.surfaceDuoInfoModel,
  });

  MultiScreenLayoutInfoModel copyWith({
    DevicePosture posture,
    SurfaceDuoInfoModel surfaceDuoInfoModel,
  }) {
    return MultiScreenLayoutInfoModel(
      posture: posture ?? this.posture,
      surfaceDuoInfoModel: surfaceDuoInfoModel ?? this.surfaceDuoInfoModel,
    );
  }

  factory MultiScreenLayoutInfoModel.fromPlatform(PlatformInfoModel info) =>
      MultiScreenLayoutInfoModel(
        posture: devicePostureFromInt(info.devicePosture),
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

DevicePosture devicePostureFromInt(int value) {
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
  /// Android folding devices that expose their folding information using
  /// the Jetpack Window Manager library.
  ///
  /// Includes: Samsung Z Fold 1/2, Samsung Z Flip
  androidStandard,
  surfaceDuo,
}
