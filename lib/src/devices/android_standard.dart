import 'package:multi_screen_layout/src/devices/surface_duo.dart';

class PlatformInfoModel {
  final SurfaceDuoInfoModel surfaceDuoInfoModel;
  final int devicePosture;
  final List<PlatformDisplayFeature> displayFeatures;

  PlatformInfoModel({
    required this.surfaceDuoInfoModel,
    required this.devicePosture,
    required this.displayFeatures,
  });

  factory PlatformInfoModel.fromJson(Map<String, dynamic> json) =>
      PlatformInfoModel(
          surfaceDuoInfoModel: json["surfaceDuoInfoModel"] != null
              ? SurfaceDuoInfoModel.fromJson(
                  json["surfaceDuoInfoModel"],
                )
              : SurfaceDuoInfoModel.unknown(),
          devicePosture: json["devicePosture"],
          displayFeatures: (json["displayFeatures"] as Iterable)
              .map((e) => PlatformDisplayFeature.fromJson(e))
              .toList());
}

class PlatformDisplayFeature {
  final int type;
  final IntRect bounds;

  PlatformDisplayFeature({
    required this.type,
    required this.bounds,
  });

  factory PlatformDisplayFeature.fromJson(Map<String, dynamic> json) =>
      PlatformDisplayFeature(
        type: json["type"],
        bounds: IntRect.fromJson(
          json["bounds"],
        ),
      );
}

class IntRect {
  final int top;
  final int bottom;
  final int left;
  final int right;

  IntRect({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });

  factory IntRect.fromJson(Map<String, dynamic> json) => IntRect(
        top: json["top"],
        bottom: json["bottom"],
        left: json["left"],
        right: json["right"],
      );
}
