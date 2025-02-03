# brightness_volume_manager

A Flutter plugin to manage screen brightness and volume on Android and iOS.
Also provides the custom widget for brightness and volume swipe.

## Features
- Get and set screen brightness 
- Reset custom brightness 
- Get and set system volume 
- Keep the screen on
- Custom swipe widget for brightness
- Custom swipe widget for volume

## Installation
Add the package to your pubspec.yaml:
```yaml
    brightness_volume_manager: ^latest_version
```
latest_version:\
[![pub package](https://img.shields.io/pub/v/brightness_volume_manager.svg)](https://pub.dartlang.org/packages/brightness_volume_manager)

### API
#### Get System brightness
```dart
    BrightnessVolumeManager().getBrightness();
```

#### Set brightness
```dart
  BrightnessVolumeManager().setBrightness(brightness);
```

#### Reset Custom brightness
```dart
  BrightnessVolumeManager().resetCustomBrightness();
```

#### Get System Volume
```dart
    BrightnessVolumeManager().getVolume();
```

#### Set volume
```dart
  BrightnessVolumeManager().setVolume(v);
```

#### Get screen kept on flag
```dart
  BrightnessVolumeManager().isScreenKeptOn();
```

#### Set screen kept on flag
```dart
  BrightnessVolumeManager().keepScreenOn(true);
```

### Add swipe widget vertical
```dart
  SwipeManager(
      initialValue: brightness,
      onChange: (v, z) {
        BrightnessVolumeManager().setBrightness(v);
      },
      direction: SlideDirection.vertical,
      childBuilder: (ctx, value) => AnimatedSwitcher(
        layoutBuilder: (Widget? currentChild,
            List<Widget> previousChildren) {
          return currentChild!;
        },
        duration: const Duration(seconds: 1),
        child: Container(),
      )
  )
```

### Add swipe widget horizontal
```dart
  SwipeManager(
    initialValue: brightness,
    width: 200,
    height: 20,
    onChange: (v, z) {
      BrightnessVolumeManager().setBrightness(v);
    },
    direction: SlideDirection.horizontal,
    childBuilder: (ctx, value) => AnimatedSwitcher(
        layoutBuilder: (Widget? currentChild,
        List<Widget> previousChildren) {
          return currentChild!;
        },
        duration: const Duration(seconds: 1),
      child: Container(),
    )
),
```
## Maintainer

[Minas Chalise](https://github.com/chaliseminas)

