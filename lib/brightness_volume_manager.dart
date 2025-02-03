/// Created by: Minas Chalise
/// 2025 Jan 31
///
/// A library that provides an interface for managing the device's brightness and volume settings.
///
/// This library allows you to get and set the screen brightness and volume levels, as well as control
/// whether the screen should stay on.
library brightness_volume_manager;

import 'brightness_volume_manager_platform_interface.dart';

export 'widgets/swipe_manager.dart';

/// Manages device brightness and volume settings.
///
/// This class provides methods to get and set the device's brightness and volume, as well as control
/// the screen's "stay on" status. It interfaces with the platform-specific implementation to perform
/// the necessary operations.
class BrightnessVolumeManager {

  /// Retrieves the current screen brightness.
  ///
  /// Returns a [Future] that completes with the current brightness level, where a value of 0.0
  /// represents the minimum brightness and 1.0 represents the maximum brightness.
  Future<double> getBrightness() {
    return BrightnessVolumeManagerPlatform.instance.getBrightness();
  }

  /// Sets the screen brightness to the specified value.
  ///
  /// The [brightness] parameter should be a value between 0.0 (minimum brightness) and 1.0 (maximum brightness).
  ///
  /// Throws an [Exception] if the brightness value is outside the valid range.
  Future<void> setBrightness(double brightness) async {
    BrightnessVolumeManagerPlatform.instance.setBrightness(brightness);
  }

  /// Resets the custom brightness setting to the default system brightness.
  ///
  /// This method restores the screen brightness to the system's default behavior.
  Future<void> resetCustomBrightness() async {
    BrightnessVolumeManagerPlatform.instance.resetCustomBrightness();
  }

  /// Retrieves the current volume level.
  ///
  /// Returns a [Future] that completes with the current volume level, where a value of 0.0
  /// represents mute and 1.0 represents maximum volume.
  Future<double> getVolume() {
    return BrightnessVolumeManagerPlatform.instance.getVolume();
  }

  /// Sets the system volume to the specified value.
  ///
  /// The [volume] parameter should be a value between 0.0 (mute) and 1.0 (maximum volume).
  ///
  /// Throws an [Exception] if the volume value is outside the valid range.
  Future<void> setVolume(double volume) async {
    BrightnessVolumeManagerPlatform.instance.setVolume(volume);
  }

  /// Checks whether the screen is set to stay on.
  ///
  /// Returns a [Future] that completes with a boolean value indicating whether the screen is kept on.
  Future<bool> isScreenKeptOn() {
    return BrightnessVolumeManagerPlatform.instance.isScreenKeptOn();
  }

  /// Sets the screen to either stay on or turn off when idle.
  ///
  /// The [status] parameter determines whether the screen should remain on. If true, the screen
  /// will stay on indefinitely, while if false, it will follow the default screen timeout behavior.
  Future<void> keepScreenOn(bool status) async {
    BrightnessVolumeManagerPlatform.instance.keepScreenOn(status);
  }
}
