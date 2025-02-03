package np.com.chalise.brightness_volume_manager

import android.app.Activity
import android.content.Context
import android.media.AudioManager
import android.view.WindowManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** BrightnessVolumeManagerPlugin */
class BrightnessVolumeManagerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var audioManager: AudioManager
    private lateinit var activity: Activity
    private lateinit var context: Context
    private var brightnessVolumeHelper: BrightnessVolumeHelper? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "brightness_volume_manager")
        channel.setMethodCallHandler(this)
        this.context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {

        if (brightnessVolumeHelper == null) {
            brightnessVolumeHelper = BrightnessVolumeHelper(activity, context)
        }

        when (call.method) {
            "getBrightness" -> {
                result.success(brightnessVolumeHelper?.getBrightness())
            }

            "setBrightness" -> {
                val brightness: Double = call.argument("brightness") ?: 0.0
                brightnessVolumeHelper?.setBrightness(brightness)
                result.success(null)
            }

            "resetCustomBrightness" -> {
                brightnessVolumeHelper?.resetCustomBrightness()
                result.success(null)
            }

            "getVolume" -> {
                result.success(brightnessVolumeHelper?.getVolume())
            }

            "setVolume" -> {
                val volume: Double = call.argument("volume") ?: 0.0
                brightnessVolumeHelper?.setVolume(volume)
                result.success(null)
            }

            "isScreenKeptOn" -> {
                val flags = activity.window.attributes.flags
                result.success((flags and WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) != 0)
            }

            "keepScreenOn" -> {
                val status: Boolean = call.argument("status") ?: false
                if (status) {
                    activity.window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                } else {
                    activity.window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
                }
                result.success(null)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        this.activity = binding.getActivity()
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}
