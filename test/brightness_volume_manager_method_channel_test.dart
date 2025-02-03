import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brightness_volume_manager/brightness_volume_manager_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelBrightnessVolumeManager platform = MethodChannelBrightnessVolumeManager();
  const MethodChannel channel = MethodChannel('brightness_volume_manager');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getBrightness(), '0.1');
  });
}
