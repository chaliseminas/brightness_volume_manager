/// Created by: Minas Chalise
/// 2025 Jan 31
///
/// An implementation of [BrightnessVolumeManagerPlatform] that uses method channels
/// to interact with the native platform for controlling brightness, volume, and screen timeout.
///
/// This class provides methods to get and set screen brightness, volume levels, and control whether
/// the screen should stay on, utilizing Flutter's method channels to communicate with native code.
library brightness_volume_manager;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'brightness_volume_manager_platform_interface.dart';

/// A [BrightnessVolumeManagerPlatform] implementation that uses method channels to communicate
/// with the native platform for managing brightness, volume, and screen behavior.
class MethodChannelBrightnessVolumeManager extends BrightnessVolumeManagerPlatform {

  /// The method channel used to interact with the native platform.
  ///
  /// This channel allows communication with the platform to perform actions such as adjusting
  /// brightness and volume, as well as controlling the screen's "stay on" behavior.
  @visibleForTesting
  final methodChannel = const MethodChannel('brightness_volume_manager');

  /// Retrieves the current screen brightness.
  ///
  /// Calls a native method to fetch the current brightness value from the platform. The returned value
  /// is a double between 0.0 (minimum brightness) and 1.0 (maximum brightness). If no value is returned,
  /// defaults to 0.0.
  ///
  /// Returns a [Future] that completes with the current brightness.
  @override
  Future<double> getBrightness() async {
    final brightness = await methodChannel.invokeMethod<double>('getBrightness');
    return brightness ?? 0.0;
  }

  /// Sets the screen brightness to the specified value.
  ///
  /// Calls a native method to set the screen brightness. The [brightness] parameter should be between
  /// 0.0 (minimum brightness) and 1.0 (maximum brightness).
  ///
  /// [brightness] The desired brightness level to set.
  @override
  Future<void> setBrightness(double brightness) async {
    await methodChannel.invokeMethod('setBrightness', {'brightness': brightness});
  }

  /// Resets the custom brightness setting to the default system brightness.
  ///
  /// Calls a native method to reset the brightness to its default system behavior.
  @override
  Future<void> resetCustomBrightness() async {
    await methodChannel.invokeMethod('resetCustomBrightness');
  }

  /// Retrieves the current system volume level.
  ///
  /// Calls a native method to fetch the current volume level from the platform. The returned value
  /// is a double between 0.0 (mute) and 1.0 (maximum volume).
  ///
  /// Returns a [Future] that completes with the current volume level.
  @override
  Future<double> getVolume() async {
    final volume = await methodChannel.invokeMethod('getVolume');
    return volume;
  }

  /// Sets the system volume to the specified value.
  ///
  /// Calls a native method to set the system volume. The [volume] parameter should be between
  /// 0.0 (mute) and 1.0 (maximum volume).
  ///
  /// [volume] The desired volume level to set.
  @override
  Future<void> setVolume(double volume) async {
    await methodChannel.invokeMethod('setVolume', {'volume': volume});
  }

  /// Checks whether the screen is set to stay on.
  ///
  /// Calls a native method to check if the screen is kept on indefinitely, or if it follows the system's
  /// default screen timeout behavior.
  ///
  /// Returns a [Future] that completes with a boolean value indicating whether the screen is kept on.
  @override
  Future<bool> isScreenKeptOn() async {
    final isKeptOn = await methodChannel.invokeMethod('isScreenKeptOn');
    return isKeptOn;
  }

  /// Sets the screen to either stay on or follow the default screen timeout behavior.
  ///
  /// Calls a native method to control whether the screen should remain on indefinitely or follow
  /// the default screen timeout behavior. The [status] parameter determines this behavior.
  ///
  /// [status] If true, the screen will stay on; if false, the screen will follow the default timeout behavior.
  @override
  Future<void> keepScreenOn(bool status) async {
    await methodChannel.invokeMethod('keepScreenOn', {'status': status});
  }
}
