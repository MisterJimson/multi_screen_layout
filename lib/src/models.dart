import 'package:multi_screen_layout/src/devices/android_standard.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';
import 'package:multi_screen_layout/src/util.dart';

/// Contains all multi screen data available
class MultiScreenLayoutInfoModel {
  final PlatformDisplayFeature platformDisplayFeature;

  /// Information from the Surface Duo SDK
  final SurfaceDuoInfoModel surfaceDuoInfoModel;

  /// Folding state of the device
  late final FoldingState foldingState;

  /// Fold direction
  late final FoldDirection foldDirection;

  /// Based on the data provided by the system, should the UI span multiple
  /// screens
  late final bool shouldDisplayAcrossScreens;

  MultiScreenLayoutInfoModel({
    required this.platformDisplayFeature,
    required this.surfaceDuoInfoModel,
  }) {
    FoldDirection foldDirection;
    if (platformDisplayFeature.bounds.top == 0 ||
        platformDisplayFeature.bounds.bottom == 0) {
      foldDirection = FoldDirection.horizontal;
    } else if (platformDisplayFeature.bounds.left == 0 ||
        platformDisplayFeature.bounds.right == 0) {
      foldDirection = FoldDirection.vertical;
    } else {
      foldDirection = FoldDirection.none;
    }

    bool shouldDisplayAcrossScreens;
    if (platformDisplayFeature.isSeparating || surfaceDuoInfoModel.isSpanned) {
      shouldDisplayAcrossScreens = true;
    } else {
      shouldDisplayAcrossScreens = false;
    }

    this.foldingState = foldingStateFromInt(platformDisplayFeature.state);
    this.foldDirection = foldDirection;
    this.shouldDisplayAcrossScreens = shouldDisplayAcrossScreens;
  }

  MultiScreenLayoutInfoModel copyWith({
    PlatformDisplayFeature? platformDisplayFeature,
    SurfaceDuoInfoModel? surfaceDuoInfoModel,
  }) {
    return MultiScreenLayoutInfoModel(
      platformDisplayFeature:
          platformDisplayFeature ?? this.platformDisplayFeature,
      surfaceDuoInfoModel: surfaceDuoInfoModel ?? this.surfaceDuoInfoModel,
    );
  }

  factory MultiScreenLayoutInfoModel.fromPlatform(PlatformInfoModel infoModel) {
    return MultiScreenLayoutInfoModel(
      platformDisplayFeature: infoModel.displayFeature,
      surfaceDuoInfoModel: infoModel.surfaceDuoInfoModel,
    );
  }
  factory MultiScreenLayoutInfoModel.unknown() => MultiScreenLayoutInfoModel(
        surfaceDuoInfoModel: SurfaceDuoInfoModel.unknown(),
        platformDisplayFeature: PlatformDisplayFeature.unknown(),
      );
}

/// The posture of a foldable device with a flexible screen or multiple physical
/// screens.
enum FoldingState {
  flat,
  halfOpened,
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
  none,
}
