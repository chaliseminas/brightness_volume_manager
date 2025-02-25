import Flutter
import UIKit
import MediaPlayer
import AVFoundation
import Darwin

public class BrightnessVolumeManagerPlugin: NSObject, FlutterPlugin {
    private var volumeView: MPVolumeView?
    private var musicController: MPMusicPlayerController?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "brightness_volume_manager", binaryMessenger: registrar.messenger())
        let instance = BrightnessVolumeManagerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private func setSystemVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        if let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider {slider.value = volume }
    }


    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getBrightness":
            result(UIScreen.main.brightness)

        case "setBrightness":
            if let args = call.arguments as? [String: Any], let brightness = args["brightness"] as? CGFloat {
                UIScreen.main.brightness = brightness
            }
            result(nil)

        case "resetCustomBrightness":
            result(nil)

        case "isScreenKeptOn":
            result(UIApplication.shared.isIdleTimerDisabled)

        case "keepScreenOn":
            if let args = call.arguments as? [String: Any], let isOn = args["on"] as? Bool {
                UIApplication.shared.isIdleTimerDisabled = isOn
            }
            result(nil)

        case "getVolume":
            let audioSession = AVAudioSession.sharedInstance()
            let currentVol = audioSession.outputVolume
            if volumeView == nil {
                volumeView = MPVolumeView(frame: CGRect(x: -100, y: 0, width: 10, height: 10))
                UIApplication.shared.keyWindow?.addSubview(volumeView!)
            }
            result(currentVol)

        case "setVolume":
            if let args = call.arguments as? [String: Any],
            let volume = args["volume"] as? Float {
                 setSystemVolume(volume)
            }
             result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}