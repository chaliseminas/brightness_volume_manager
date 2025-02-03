/// Created by: Minas Chalise
/// 2025 jan 31
library brightness_volume_manager;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'brightness_volume_manager_platform_interface.dart';

/// An implementation of [BrightnessVolumeManagerPlatform] that uses method channels.
class MethodChannelBrightnessVolumeManager
    extends BrightnessVolumeManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('brightness_volume_manager');

  @override
  Future<double> getBrightness() async {
    final brightness =
        await methodChannel.invokeMethod<double>('getBrightness');
    return brightness ?? 0.0;
  }

  @override
  Future<void> setBrightness(double brightness) async {
    await methodChannel
        .invokeMethod('setBrightness', {'brightness': brightness});
  }

  @override
  Future<void> resetCustomBrightness() async {
    await methodChannel.invokeMethod('resetCustomBrightness');
  }

  @override
  Future<double> getVolume() async {
    final volume = await methodChannel.invokeMethod('getVolume');
    return volume;
  }

  @override
  Future<void> setVolume(double volume) async {
    await methodChannel.invokeMethod('setVolume', {'volume': volume});
  }

  @override
  Future<bool> isScreenKeptOn() async {
    final isKeptOn = await methodChannel.invokeMethod('isScreenKeptOn');
    return isKeptOn;
  }

  @override
  Future<void> keepScreenOn(bool status) async {
    await methodChannel.invokeMethod('keepScreenOn', {'status': status});
  }
}
