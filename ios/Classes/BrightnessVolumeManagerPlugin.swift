import Flutter
import UIKit
import MediaPlayer
import AVFoundation
import Darwin

public class BrightnessVolumePlugin: NSObject, FlutterPlugin {
    private var volumeView: MPVolumeView?
    private var musicController: MPMusicPlayerController?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "brightness_volume", binaryMessenger: registrar.messenger())
        let instance = BrightnessVolumePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
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
            if let args = call.arguments as? [String: Any], let volume = args["volume"] as? Float {
                if musicController == nil {
                    musicController = MPMusicPlayerController.applicationMusicPlayer
                }
                musicController?.volume = volume
            }
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}