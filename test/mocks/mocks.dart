import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void mockPlatformHanlder() {
  const channel = MethodChannel('multi_screen_layout');

  handler(MethodCall methodCall) async {
    if (methodCall.method == 'getInfoModel') {
      return <String, dynamic>{
        'test': 'test',
      };
    }
    return null;
  }

  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);
}
