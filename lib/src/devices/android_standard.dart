import 'package:multi_screen_layout/src/devices/surface_duo.dart';

class PlatformInfoModel {
  final SurfaceDuoInfoModel surfaceDuoInfoModel;
  final int devicePosture;
  final List<PlatformDisplayFeature> displayFeatures;

  PlatformInfoModel({
    this.surfaceDuoInfoModel,
    this.devicePosture,
    this.displayFeatures,
  });

  factory PlatformInfoModel.fromJson(Map<String, dynamic> json) =>
      PlatformInfoModel(
          surfaceDuoInfoModel: json["surfaceDuoInfoModel"] != null
              ? SurfaceDuoInfoModel.fromJson(
                  json["surfaceDuoInfoModel"],
                )
              : null,
          devicePosture: json["devicePosture"],
          displayFeatures: (json["displayFeatures"] as Iterable)
              .map((e) => PlatformDisplayFeature.fromJson(e))
              .toList());
}

class PlatformDisplayFeature {
  final int type;
  final IntRect bounds;

  PlatformDisplayFeature({
    this.type,
    this.bounds,
  });

  factory PlatformDisplayFeature.fromJson(Map<String, dynamic> json) =>
      PlatformDisplayFeature(
        type: json["type"],
        bounds: json["bounds"] != null
            ? IntRect.fromJson(
                json["bounds"],
              )
            : null,
      );
}

class IntRect {
  final int top;
  final int bottom;
  final int left;
  final int right;

  IntRect({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  factory IntRect.fromJson(Map<String, dynamic> json) => IntRect(
        top: json["top"],
        bottom: json["bottom"],
        left: json["left"],
        right: json["right"],
      );
}
