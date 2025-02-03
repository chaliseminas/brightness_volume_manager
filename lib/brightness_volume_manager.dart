/// Created by: Minas Chalise
/// 2025 jan 31
library brightness_volume_manager;

import 'brightness_volume_manager_platform_interface.dart';

export 'widgets/swipe_manager.dart';

class BrightnessVolumeManager {
  Future<double> getBrightness() {
    return BrightnessVolumeManagerPlatform.instance.getBrightness();
  }

  Future<void> setBrightness(double brightness) async {
    BrightnessVolumeManagerPlatform.instance.setBrightness(brightness);
  }

  Future<void> resetCustomBrightness() async {
    BrightnessVolumeManagerPlatform.instance.resetCustomBrightness();
  }

  Future<double> getVolume() {
    return BrightnessVolumeManagerPlatform.instance.getVolume();
  }

  Future<void> setVolume(double volume) async {
    BrightnessVolumeManagerPlatform.instance.setVolume(volume);
  }

  Future<bool> isScreenKeptOn() {
    return BrightnessVolumeManagerPlatform.instance.isScreenKeptOn();
  }

  Future<void> keepScreenOn(bool status) async {
    BrightnessVolumeManagerPlatform.instance.keepScreenOn(status);
  }
}
