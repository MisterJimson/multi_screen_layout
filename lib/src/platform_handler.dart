import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:multi_screen_layout/src/devices/android_standard.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';
import 'package:multi_screen_layout/src/models.dart';

const _methodChannel = const MethodChannel('multi_screen_layout');

const _devicePostureEventChannel =
    const EventChannel('multi_screen_layout_layout_state_change');

/// Provides access to the platform to get multi screen information
class MultiScreenPlatformHandler {
  MultiScreenPlatformHandler._();

  /// Directly listen to changes in device posture
  static Stream<PlatformDisplayFeature> onFoldingDisplayFeatureChanged =
      _setupOnFoldingDisplayFeatureChanged();

  /// Provides access to SurfaceDuo specific information
  static SurfaceDuoPlatformHandler surfaceDuo = SurfaceDuoPlatformHandler._();

  /// Gets all relevant multi screen information in one call to the platform
  static Future<MultiScreenLayoutInfoModel> getInfoModel() async {
    if (!Platform.isAndroid) return MultiScreenLayoutInfoModel.unknown();
    final result = await _methodChannel.invokeMethod<String>('getInfoModel');
    if (result == null) {
      return MultiScreenLayoutInfoModel.unknown();
    } else {
      var infoModel = PlatformInfoModel.fromJson(jsonDecode(result));
      return MultiScreenLayoutInfoModel.fromPlatform(infoModel);
    }
  }

  static Stream<PlatformDisplayFeature> _setupOnFoldingDisplayFeatureChanged() {
    if (!Platform.isAndroid)
      return _unsupportedOnFoldingDisplayFeatureChanged().asBroadcastStream();

    return _devicePostureEventChannel.receiveBroadcastStream().map((value) {
      return value == null
          ? PlatformDisplayFeature.unknown()
          : PlatformDisplayFeature.fromJson(jsonDecode(value));
    });
  }

  static Stream<PlatformDisplayFeature>
      _unsupportedOnFoldingDisplayFeatureChanged() async* {
    yield PlatformDisplayFeature.unknown();
  }
}

/// Provides access to the platform to get Surface Duo specific information
class SurfaceDuoPlatformHandler {
  SurfaceDuoPlatformHandler._();

  static Future<bool> getIsDual() async {
    if (!Platform.isAndroid) return false;
    final isDual =
        await _methodChannel.invokeMethod<bool>('isDualScreenDevice');
    return isDual ?? false;
  }

  static Future<bool> getIsSpanned() async {
    if (!Platform.isAndroid) return false;
    final isAppSpanned =
        await _methodChannel.invokeMethod<bool>('isAppSpanned');
    return isAppSpanned ?? false;
  }

  static Future<double> getHingeAngle() async {
    if (!Platform.isAndroid) return 0;
    final hingeAngle =
        await _methodChannel.invokeMethod<double>('getHingeAngle');
    return hingeAngle ?? 0;
  }

  static Future<NonFunctionalBounds> getNonFunctionalBounds() async {
    if (!Platform.isAndroid) return NonFunctionalBounds.none();
    final result =
        await _methodChannel.invokeMethod<String>('getNonFunctionalBounds');
    if (result == null) {
      return NonFunctionalBounds.none();
    } else {
      return NonFunctionalBounds.fromJson(jsonDecode(result));
    }
  }
}
