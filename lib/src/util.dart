import 'package:multi_screen_layout/src/models.dart';

FoldingState foldingStateFromString(String value) {
  switch (value) {
    case 'FLAT':
      return FoldingState.flat;
    case 'HALF_OPENED':
      return FoldingState.halfOpened;
    default:
      return FoldingState.unknown;
  }
}
