package np.com.chalise.brightness_volume_manager

import android.app.Activity
import android.content.Context
import android.media.AudioManager
import android.provider.Settings
import android.view.WindowManager

class BrightnessVolumeHelper constructor(
    private val activity: Activity,
    private val context: Context
) {

    private var audioManager: AudioManager? = null

    fun getBrightness(): Float {
        var brightness = activity.window.attributes.screenBrightness
        if (brightness < 0) {
            try {
                brightness = Settings.System.getInt(
                    context.contentResolver,
                    Settings.System.SCREEN_BRIGHTNESS
                ) / 255.0f
            } catch (e: Settings.SettingNotFoundException) {
                brightness = 1.0f
                e.printStackTrace()
            }
        }
        return brightness
    }

    fun setBrightness(brightness: Double) {
        val layoutParams: WindowManager.LayoutParams = activity.window.attributes
        layoutParams.screenBrightness = brightness.toFloat()
        activity.window.attributes = layoutParams
    }

    fun resetCustomBrightness() {
        val layoutParams: WindowManager.LayoutParams = activity.window.attributes
        layoutParams.screenBrightness = WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE
        activity.window.attributes = layoutParams
    }

    fun getVolume(): Float {
        if (audioManager == null) {
            audioManager = activity.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        }
        val max = audioManager!!.getStreamMaxVolume(AudioManager.STREAM_MUSIC).toFloat()
        val current = audioManager!!.getStreamVolume(AudioManager.STREAM_MUSIC).toFloat()
        val volume = current / max

        return volume
    }

    fun setVolume(volume: Double) {
        if (audioManager == null) {
            audioManager = activity.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        }
        val max = audioManager!!.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        audioManager!!.setStreamVolume(
            AudioManager.STREAM_MUSIC,
            (max * volume).toInt(),
            AudioManager.FLAG_PLAY_SOUND
        )
    }
}