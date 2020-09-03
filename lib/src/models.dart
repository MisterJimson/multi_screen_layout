import 'package:multi_screen_layout/src/devices/surface_duo.dart';

/// Contains all multi screen data our widgets need to layout
class MultiScreenLayoutInfoModel {
  final SurfaceDuoInfoModel surfaceDuoInfoModel;

  bool get isSpanned => surfaceDuoInfoModel.isSpanned;

  MultiScreenLayoutInfoModel({this.surfaceDuoInfoModel});

  factory MultiScreenLayoutInfoModel.unknown() => MultiScreenLayoutInfoModel(
        surfaceDuoInfoModel: SurfaceDuoInfoModel.unknown(),
      );
}
