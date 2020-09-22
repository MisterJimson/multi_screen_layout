import 'package:multi_screen_layout/src/devices/android_standard.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';
import 'package:multi_screen_layout/src/util.dart';

/// Contains all multi screen data available
class MultiScreenLayoutInfoModel {
  /// Posture of the device
  final DevicePosture posture;

  /// Fold direction
  final FoldDirection foldDirection;

  /// Information from the Surface Duo SDK
  final SurfaceDuoInfoModel surfaceDuoInfoModel;

  MultiScreenLayoutInfoModel({
    this.posture,
    this.surfaceDuoInfoModel,
    this.foldDirection,
  });

  MultiScreenLayoutInfoModel copyWith({
    DevicePosture posture,
    FoldDirection foldDirection,
    SurfaceDuoInfoModel surfaceDuoInfoModel,
  }) {
    return MultiScreenLayoutInfoModel(
      posture: posture ?? this.posture,
      foldDirection: foldDirection ?? this.foldDirection,
      surfaceDuoInfoModel: surfaceDuoInfoModel ?? this.surfaceDuoInfoModel,
    );
  }

  factory MultiScreenLayoutInfoModel.fromPlatform(PlatformInfoModel info) {
    FoldDirection foldDirection;
    if (info.displayFeatures.length == 1) {
      foldDirection = info.displayFeatures.first.bounds.top == 0 ||
              info.displayFeatures.first.bounds.bottom == 0
          ? FoldDirection.horizontal
          : FoldDirection.vertical;
    }
    return MultiScreenLayoutInfoModel(
      posture: devicePostureFromInt(info.devicePosture),
      foldDirection: foldDirection,
      surfaceDuoInfoModel:
          info.surfaceDuoInfoModel ?? SurfaceDuoInfoModel.unknown(),
    );
  }

  factory MultiScreenLayoutInfoModel.unknown() => MultiScreenLayoutInfoModel(
        surfaceDuoInfoModel: SurfaceDuoInfoModel.unknown(),
      );
}

/// The posture of a foldable device with a flexible screen or multiple physical
/// screens.
enum DevicePosture {
  closed,
  flipped,
  halfOpened,
  opened,
  unknown,
}

enum MultiScreenType {
  /// Android folding devices that expose their folding information using
  /// the Jetpack Window Manager library.
  ///
  /// Includes: Samsung Z Fold 1/2, Samsung Z Flip
  androidStandard,

  /// Microsoft's Surface Duo
  surfaceDuo,
}

/// The direction parts of the screen would move to fold the device. This can
/// change as the device is rotated.
///
/// For example if a device folds like a book, it folds horizontally.
enum FoldDirection {
  vertical,
  horizontal,
}
