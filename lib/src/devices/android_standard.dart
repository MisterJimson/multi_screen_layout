import 'package:multi_screen_layout/src/devices/surface_duo.dart';

class PlatformInfoModel {
  final SurfaceDuoInfoModel surfaceDuoInfoModel;
  final int devicePosture;

  PlatformInfoModel({
    this.surfaceDuoInfoModel,
    this.devicePosture,
  });

  factory PlatformInfoModel.fromJson(Map<String, dynamic> json) =>
      PlatformInfoModel(
        surfaceDuoInfoModel: json["surfaceDuoInfoModel"] != null
            ? SurfaceDuoInfoModel.fromJson(
                json["surfaceDuoInfoModel"],
              )
            : null,
        devicePosture: json["devicePosture"],
      );
}
