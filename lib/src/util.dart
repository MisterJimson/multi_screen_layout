import 'package:multi_screen_layout/src/models.dart';

FoldingState foldingStateFromInt(int value) {
  switch (value) {
    case 1:
      return FoldingState.flat;
    case 2:
      return FoldingState.halfOpened;
    default:
      return FoldingState.unknown;
  }
}
