import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

void main() {
  group('TwoPageLayout', () {
    testWidgets('Diplays child but not secondChild on non Android platforms',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TwoPageLayout(
          child: SizedBox(
            key: Key('box1'),
          ),
          secondChild: SizedBox(
            key: Key('box2'),
          ),
        ),
      );

      expect(find.byKey(Key('box1')), findsOneWidget);
      expect(find.byKey(Key('box2')), findsNothing);
    }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));

    //todo ensure platform call is used
    testWidgets(
        'Diplays child but not secondChild when PlatformDisplayFeature.isSeparating is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TwoPageLayout(
          child: SizedBox(
            key: Key('box1'),
          ),
          secondChild: SizedBox(
            key: Key('box2'),
          ),
        ),
      );

      expect(find.byKey(Key('box1')), findsOneWidget);
      expect(find.byKey(Key('box2')), findsNothing);

      tester.pumpAndSettle();
    }, variant: TargetPlatformVariant.only(TargetPlatform.android));
  });
}
