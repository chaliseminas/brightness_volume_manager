/// Created by: Minas Chalise
/// 2025 Jan 31
///
/// An abstract platform interface for managing device brightness, volume, and screen behavior.
///
/// This class defines the methods that must be implemented by the platform-specific code to interact
/// with the device's brightness, volume, and screen timeout behavior. The platform-specific implementation
/// will use the appropriate platform channels to perform the necessary operations.
library brightness_volume_manager;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'brightness_volume_manager_method_channel.dart';

/// The platform interface for the BrightnessVolumeManager plugin.
///
/// This class defines the abstract methods that must be implemented by a platform-specific subclass.
/// It serves as a common interface for interacting with the device's brightness, volume, and screen
/// behavior settings.
abstract class BrightnessVolumeManagerPlatform extends PlatformInterface {

  /// Constructs a [BrightnessVolumeManagerPlatform].
  ///
  /// This constructor is called to initialize the platform interface, allowing subclasses to be verified.
  BrightnessVolumeManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static BrightnessVolumeManagerPlatform _instance =
  MethodChannelBrightnessVolumeManager();

  /// The default instance of [BrightnessVolumeManagerPlatform] to use.
  ///
  /// This static getter returns the default instance of the platform interface, which is typically
  /// [MethodChannelBrightnessVolumeManager]. This can be overridden by setting [instance] to a custom
  /// platform-specific implementation.
  static BrightnessVolumeManagerPlatform get instance => _instance;

  /// Sets the platform-specific instance of [BrightnessVolumeManagerPlatform].
  ///
  /// This static setter allows the user to set a custom platform-specific implementation of this
  /// interface. Platform implementations must extend [BrightnessVolumeManagerPlatform].
  static set instance(BrightnessVolumeManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Retrieves the current screen brightness.
  ///
  /// This method should be implemented by platform-specific code to fetch the current screen brightness
  /// level. A value between 0.0 (minimum brightness) and 1.0 (maximum brightness) should be returned.
  ///
  /// Returns a [Future] that completes with the current brightness value.
  Future<double> getBrightness() {
    throw UnimplementedError('getBrightness() has not been implemented.');
  }

  /// Sets the screen brightness to the specified value.
  ///
  /// This method should be implemented by platform-specific code to set the screen brightness to the
  /// specified level. The [brightness] parameter should be a value between 0.0 (minimum brightness) and
  /// 1.0 (maximum brightness).
  ///
  /// [brightness] The desired brightness level to set.
  Future<void> setBrightness(double brightness) {
    throw UnimplementedError('setBrightness() has not been implemented.');
  }

  /// Resets the custom brightness setting to the default system brightness.
  ///
  /// This method should be implemented by platform-specific code to reset the screen brightness to its
  /// default system behavior.
  Future<void> resetCustomBrightness() {
    throw UnimplementedError('resetCustomBrightness() has not been implemented.');
  }

  /// Retrieves the current system volume level.
  ///
  /// This method should be implemented by platform-specific code to fetch the current volume level. The
  /// returned value should be between 0.0 (mute) and 1.0 (maximum volume).
  ///
  /// Returns a [Future] that completes with the current volume level.
  Future<double> getVolume() {
    throw UnimplementedError('getVolume() has not been implemented.');
  }

  /// Sets the system volume to the specified value.
  ///
  /// This method should be implemented by platform-specific code to set the system volume to the specified
  /// level. The [volume] parameter should be a value between 0.0 (mute) and 1.0 (maximum volume).
  ///
  /// [volume] The desired volume level to set.
  Future<void> setVolume(double volume) {
    throw UnimplementedError('setVolume() has not been implemented.');
  }

  /// Checks whether the screen is set to stay on.
  ///
  /// This method should be implemented by platform-specific code to check if the screen is kept on
  /// indefinitely, or if it follows the default system screen timeout behavior.
  ///
  /// Returns a [Future] that completes with a boolean indicating whether the screen is kept on.
  Future<bool> isScreenKeptOn() {
    throw UnimplementedError('isScreenKeptOn() has not been implemented.');
  }

  /// Sets the screen to either stay on or follow the default screen timeout behavior.
  ///
  /// This method should be implemented by platform-specific code to set the screen to either stay on
  /// indefinitely or follow the default screen timeout behavior based on the provided [status] parameter.
  ///
  /// [status] If true, the screen will stay on indefinitely; if false, the screen will follow the default
  /// timeout behavior.
  Future<void> keepScreenOn(bool status) {
    throw UnimplementedError('keepScreenOn() has not been implemented.');
  }
}
