import 'package:multi_screen_layout/src/models.dart';

DevicePosture devicePostureFromInt(int value) {
  switch (value) {
    case 1:
      return DevicePosture.closed;
    case 4:
      return DevicePosture.flipped;
    case 2:
      return DevicePosture.halfOpened;
    case 3:
      return DevicePosture.opened;
    default:
      return DevicePosture.unknown;
  }
}
