/// Contains data specific to the SurfaceDuo, this may be able to be made generic
/// as more multi screen devices become available
class SurfaceDuoInfoModel {
  final bool isDualScreenDevice;
  final bool isSpanned;
  final double hingeAngle;
  final NonFunctionalBounds nonFunctionalBounds;

  double get seemThickness =>
      (nonFunctionalBounds?.right ?? 0) - (nonFunctionalBounds?.left ?? 0);

  SurfaceDuoInfoModel({
    this.isDualScreenDevice,
    this.isSpanned,
    this.hingeAngle,
    this.nonFunctionalBounds,
  });

  factory SurfaceDuoInfoModel.unknown() => SurfaceDuoInfoModel(
        isDualScreenDevice: false,
        isSpanned: false,
        hingeAngle: 0,
        nonFunctionalBounds: null,
      );

  factory SurfaceDuoInfoModel.fromJson(Map<String, dynamic> json) =>
      SurfaceDuoInfoModel(
        isDualScreenDevice: json["isDualScreenDevice"],
        isSpanned: json["isSpanned"],
        hingeAngle: json["hingeAngle"],
        nonFunctionalBounds: json["nonFunctionalBounds"] != null
            ? NonFunctionalBounds.fromJson(
                json["nonFunctionalBounds"],
              )
            : null,
      );
}

class NonFunctionalBounds {
  final double top;
  final double bottom;
  final double left;
  final double right;

  NonFunctionalBounds({
    this.bottom,
    this.left,
    this.right,
    this.top,
  });

  factory NonFunctionalBounds.fromJson(Map<String, dynamic> json) =>
      NonFunctionalBounds(
        bottom: json["bottom"],
        left: json["left"],
        right: json["right"],
        top: json["top"],
      );

  Map<String, dynamic> toJson() => {
        "bottom": bottom,
        "left": left,
        "right": right,
        "top": top,
      };
}
