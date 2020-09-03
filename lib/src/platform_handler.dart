import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:multi_screen_layout/src/devices/surface_duo.dart';
import 'package:multi_screen_layout/src/models.dart';

const MethodChannel _channel = const MethodChannel('multi_screen_layout');

/// Provides access to the platform to get multi screen information
class MultiScreenPlatformHandler {
  MultiScreenPlatformHandler._();

  /// Provides access to SurfaceDuo specific information
  static SurfaceDuoPlatformHandler surfaceDuo = SurfaceDuoPlatformHandler._();

  /// Gets all relevant multi screen information in one call to the platform
  static Future<MultiScreenLayoutInfoModel> getInfoModel() async {
    if (!Platform.isAndroid) return null;
    final result = await _channel.invokeMethod<String>('getInfoModel');
    if (result == null) {
      return null;
    } else {
      return MultiScreenLayoutInfoModel(
        surfaceDuoInfoModel: SurfaceDuoInfoModel.fromJson(jsonDecode(result)),
      );
    }
  }
}

/// Provides access to the platform to get Surface Duo specific information
class SurfaceDuoPlatformHandler {
  SurfaceDuoPlatformHandler._();

  static Future<bool> getIsDual() async {
    if (!Platform.isAndroid) return false;
    final isDual = await _channel.invokeMethod<bool>('isDualScreenDevice');
    return isDual;
  }

  static Future<bool> getIsSpanned() async {
    if (!Platform.isAndroid) return false;
    final isAppSpanned = await _channel.invokeMethod<bool>('isAppSpanned');
    return isAppSpanned;
  }

  static Future<double> getHingeAngle() async {
    if (!Platform.isAndroid) return null;
    final hingeAngle = await _channel.invokeMethod<double>('getHingeAngle');
    return hingeAngle;
  }

  static Future<NonFunctionalBounds> getNonFunctionalBounds() async {
    if (!Platform.isAndroid) return null;
    final result =
        await _channel.invokeMethod<String>('getNonFunctionalBounds');
    if (result == null) {
      return null;
    } else {
      return NonFunctionalBounds.fromJson(jsonDecode(result));
    }
  }
}
