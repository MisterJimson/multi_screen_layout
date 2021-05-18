import 'package:multi_screen_layout/src/devices/android_standard.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';
import 'package:multi_screen_layout/src/util.dart';

/// Contains all multi screen data available
class MultiScreenLayoutInfoModel {
  /// Folding state of the device
  final FoldingState foldingState;

  /// Fold direction
  final FoldDirection foldDirection;

  /// Information from the Surface Duo SDK
  final SurfaceDuoInfoModel surfaceDuoInfoModel;

  /// Based on the data provided by the system, should the UI span multiple
  /// screens
  final bool shouldDisplayAcrossScreens;

  MultiScreenLayoutInfoModel({
    required this.foldingState,
    required this.surfaceDuoInfoModel,
    required this.foldDirection,
    required this.shouldDisplayAcrossScreens,
  });

  MultiScreenLayoutInfoModel copyWith({
    FoldingState? foldingState,
    FoldDirection? foldDirection,
    SurfaceDuoInfoModel? surfaceDuoInfoModel,
    bool? shouldDisplayAcrossScreens,
  }) {
    return MultiScreenLayoutInfoModel(
      foldingState: foldingState ?? this.foldingState,
      foldDirection: foldDirection ?? this.foldDirection,
      surfaceDuoInfoModel: surfaceDuoInfoModel ?? this.surfaceDuoInfoModel,
      shouldDisplayAcrossScreens:
          shouldDisplayAcrossScreens ?? this.shouldDisplayAcrossScreens,
    );
  }

  //todo FoldDirection for Surface Duo
  factory MultiScreenLayoutInfoModel.fromPlatform(PlatformInfoModel info) {
    var hasFoldingDisplayFeature = info.displayFeatures.length == 1;

    FoldDirection foldDirection;
    if (hasFoldingDisplayFeature) {
      foldDirection = info.displayFeatures.first.bounds.top == 0 ||
              info.displayFeatures.first.bounds.bottom == 0
          ? FoldDirection.horizontal
          : FoldDirection.vertical;
    } else {
      foldDirection = FoldDirection.none;
    }

    bool shouldDisplayAcrossScreens;
    if (hasFoldingDisplayFeature) {
      shouldDisplayAcrossScreens = info.displayFeatures.first.isSeparating;
    } else if (info.surfaceDuoInfoModel.isSpanned) {
      shouldDisplayAcrossScreens = true;
    } else {
      shouldDisplayAcrossScreens = false;
    }

    return MultiScreenLayoutInfoModel(
      foldingState: hasFoldingDisplayFeature
          ? foldingStateFromInt(info.displayFeatures.first.state)
          : FoldingState.unknown,
      foldDirection: foldDirection,
      surfaceDuoInfoModel: info.surfaceDuoInfoModel,
      shouldDisplayAcrossScreens: shouldDisplayAcrossScreens,
    );
  }

  factory MultiScreenLayoutInfoModel.unknown() => MultiScreenLayoutInfoModel(
        surfaceDuoInfoModel: SurfaceDuoInfoModel.unknown(),
        foldDirection: FoldDirection.none,
        foldingState: FoldingState.unknown,
        shouldDisplayAcrossScreens: false,
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
