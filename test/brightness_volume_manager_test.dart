import 'package:flutter_test/flutter_test.dart';
import 'package:brightness_volume_manager/brightness_volume_manager.dart';
import 'package:brightness_volume_manager/brightness_volume_manager_platform_interface.dart';
import 'package:brightness_volume_manager/brightness_volume_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBrightnessVolumeManagerPlatform
    with MockPlatformInterfaceMixin
    implements BrightnessVolumeManagerPlatform {

  @override
  Future<double> getBrightness() {
    return Future.value(0.1);
  }

  @override
  Future<double> getVolume() {
    return Future.value(0.4);
  }

  @override
  Future<bool> isScreenKeptOn() {
    return Future.value(false);
  }

  @override
  Future<void> keepScreenOn(bool status) async {
    BrightnessVolumeManagerPlatform.instance.keepScreenOn(status);
  }

  @override
  Future<void> resetCustomBrightness() async {
    BrightnessVolumeManagerPlatform.instance.resetCustomBrightness();
  }

  @override
  Future<void> setBrightness(double brightness) async {
    BrightnessVolumeManagerPlatform.instance.setBrightness(brightness);
  }

  @override
  Future<void> setVolume(double volume) async {
    BrightnessVolumeManagerPlatform.instance.setVolume(volume);

  }
}

void main() {
  final BrightnessVolumeManagerPlatform initialPlatform = BrightnessVolumeManagerPlatform.instance;

  test('$MethodChannelBrightnessVolumeManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBrightnessVolumeManager>());
  });

  test('getPlatformVersion', () async {
    BrightnessVolumeManager brightnessVolumeManagerPlugin = BrightnessVolumeManager();
    MockBrightnessVolumeManagerPlatform fakePlatform = MockBrightnessVolumeManagerPlatform();
    BrightnessVolumeManagerPlatform.instance = fakePlatform;

    expect(await brightnessVolumeManagerPlugin.getBrightness(), '0.1');
  });
}
