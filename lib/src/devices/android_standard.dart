import 'package:multi_screen_layout/src/devices/surface_duo.dart';

class PlatformInfoModel {
  final SurfaceDuoInfoModel surfaceDuoInfoModel;
  final List<PlatformDisplayFeature> displayFeatures;

  PlatformInfoModel({
    required this.surfaceDuoInfoModel,
    required this.displayFeatures,
  });

  factory PlatformInfoModel.fromJson(Map<String, dynamic> json) =>
      PlatformInfoModel(
          surfaceDuoInfoModel: json["surfaceDuoInfoModel"] != null
              ? SurfaceDuoInfoModel.fromJson(
                  json["surfaceDuoInfoModel"],
                )
              : SurfaceDuoInfoModel.unknown(),
          displayFeatures: (json["displayFeatures"] as Iterable)
              .map((e) => PlatformDisplayFeature.fromJson(e))
              .toList());
}

class PlatformDisplayFeature {
  final int state;
  final bool isSeparating;
  final IntRect bounds;

  PlatformDisplayFeature({
    required this.state,
    required this.isSeparating,
    required this.bounds,
  });

  factory PlatformDisplayFeature.fromJson(Map<String, dynamic> json) =>
      PlatformDisplayFeature(
        state: json["state"],
        isSeparating: json['isSeparating'],
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
