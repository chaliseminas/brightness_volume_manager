/// Created by: Minas Chalise
/// 2025 jan 31
library brightness_volume_manager;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'brightness_volume_manager_method_channel.dart';

abstract class BrightnessVolumeManagerPlatform extends PlatformInterface {
  /// Constructs a BrightnessVolumeManagerPlatform.
  BrightnessVolumeManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static BrightnessVolumeManagerPlatform _instance =
      MethodChannelBrightnessVolumeManager();

  /// The default instance of [BrightnessVolumeManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelBrightnessVolumeManager].
  static BrightnessVolumeManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BrightnessVolumeManagerPlatform] when
  /// they register themselves.
  static set instance(BrightnessVolumeManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<double> getBrightness() {
    throw UnimplementedError('getBrightness() has not been implemented.');
  }

  Future<void> setBrightness(double brightness) {
    throw UnimplementedError('setBrightness() has not been implemented.');
  }

  Future<void> resetCustomBrightness() {
    throw UnimplementedError(
        'resetCustomBrightness() has not been implemented.');
  }

  Future<double> getVolume() {
    throw UnimplementedError('getVolume() has not been implemented.');
  }

  Future<void> setVolume(double volume) {
    throw UnimplementedError('setVolume() has not been implemented.');
  }

  Future<bool> isScreenKeptOn() {
    throw UnimplementedError('isScreenKeptOn() has not been implemented.');
  }

  Future<void> keepScreenOn(bool status) {
    throw UnimplementedError('keepScreenOn() has not been implemented.');
  }
}
