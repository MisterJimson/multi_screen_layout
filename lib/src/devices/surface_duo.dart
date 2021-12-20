/// Contains data specific to the SurfaceDuo
class SurfaceDuoInfoModel {
  final bool isDualScreenDevice;
  final bool isSpanned;
  final double hingeAngle;
  final NonFunctionalBounds nonFunctionalBounds;

  double get seemThickness =>
      (nonFunctionalBounds.right) - (nonFunctionalBounds.left);

  SurfaceDuoInfoModel({
    required this.isDualScreenDevice,
    required this.isSpanned,
    required this.hingeAngle,
    required this.nonFunctionalBounds,
  });

  factory SurfaceDuoInfoModel.unknown() => SurfaceDuoInfoModel(
        isDualScreenDevice: false,
        isSpanned: false,
        hingeAngle: 0,
        nonFunctionalBounds: NonFunctionalBounds.none(),
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
            : NonFunctionalBounds.none(),
      );

  SurfaceDuoInfoModel copyWith({
    bool? isDualScreenDevice,
    bool? isSpanned,
    double? hingeAngle,
    NonFunctionalBounds? nonFunctionalBounds,
  }) {
    return SurfaceDuoInfoModel(
      isDualScreenDevice: isDualScreenDevice ?? this.isDualScreenDevice,
      isSpanned: isSpanned ?? this.isSpanned,
      hingeAngle: hingeAngle ?? this.hingeAngle,
      nonFunctionalBounds: nonFunctionalBounds ?? this.nonFunctionalBounds,
    );
  }
}

class NonFunctionalBounds {
  final double top;
  final double bottom;
  final double left;
  final double right;

  NonFunctionalBounds({
    required this.bottom,
    required this.left,
    required this.right,
    required this.top,
  });

  factory NonFunctionalBounds.fromJson(Map<String, dynamic> json) =>
      NonFunctionalBounds(
        bottom: json["bottom"],
        left: json["left"],
        right: json["right"],
        top: json["top"],
      );

  factory NonFunctionalBounds.none() => NonFunctionalBounds(
        bottom: 0,
        left: 0,
        right: 0,
        top: 0,
      );

  Map<String, dynamic> toJson() => {
        "bottom": bottom,
        "left": left,
        "right": right,
        "top": top,
      };
}
