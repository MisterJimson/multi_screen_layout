package com.jrai.multi_screen_layout

import android.app.Activity
import android.content.Context.SENSOR_SERVICE
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.core.util.Consumer
import androidx.window.DeviceState
import androidx.window.WindowManager
import com.microsoft.device.display.DisplayMask
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.google.gson.Gson
import java.util.concurrent.Executor

class MultiScreenLayoutPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  private var activity: Activity? = null;

  // Surface Duo SDK
  private val HINGE_ANGLE_SENSOR_NAME = "Hinge Angle"
  private var mSensorsSetup: Boolean = false
  private var mSensorManager: SensorManager? = null
  private var mHingeAngleSensor: Sensor? = null
  private var mSensorListener: SensorEventListener? = null
  private var mCurrentHingeAngle: Float = 0.0f

  // AndroidX Window Manager Device Posture
  private var windowManager: WindowManager? = null
  private val deviceStateChangeCallback = DeviceStateChangeCallback()
  private var deviceState: DeviceState? = null
  private val handler = Handler(Looper.getMainLooper())
  val mainThreadExecutor = Executor { r: Runnable -> handler.post(r) }

  inner class DeviceStateChangeCallback : Consumer<DeviceState> {
    override fun accept(newLayoutInfo: DeviceState) {
      deviceState = newLayoutInfo
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "multi_screen_layout")
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "multi_screen_layout")
      channel.setMethodCallHandler(MultiScreenLayoutPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val isDual = isDualScreenDevice() ?: false
    try {
      if (call.method == "isDualScreenDevice") {
        result.success(isDual)
      } else if (call.method == "isAppSpanned") {
        if (!isDual) {
          result.success(false)
          return
        }
        val isAppSpanned = isAppSpanned();
        if (isAppSpanned != null && isAppSpanned) {
          result.success(true)
        } else {
          result.success(false)
        }
      } else if (call.method == "getNonFunctionalBounds") {
        if (!isDual) {
          result.success(null)
          return
        }
        val nonFunctionalBounds = getNonFunctionalBounds();
        if (nonFunctionalBounds == null) {
          result.success(null)
        } else {
          val json = Gson().toJson(nonFunctionalBounds)
          result.success(json)
        }
      } else if (call.method == "getInfoModel") {
        if (!isDual) {
          result.success(null)
          return
        }
        if (!mSensorsSetup) {
          setupSensors()
        }
        val infoModel = getInfoModel();
        if (infoModel == null) {
          result.success(null)
        } else {
          val json = Gson().toJson(infoModel)
          result.success(json)
        }
      } else if (call.method == "getSurfaceDuoInfoModel") {
        if (!isDual) {
          result.success(null)
          return
        }
        if (!mSensorsSetup) {
          setupSensors()
        }
        val infoModel = getSurfaceDuoInfoModel();
        if (infoModel == null) {
          result.success(null)
        } else {
          val json = Gson().toJson(infoModel)
          result.success(json)
        }
      } else if (call.method == "getHingeAngle") {
        if (!isDual) {
          result.success(null)
          return
        }
        if (!mSensorsSetup) {
          setupSensors()
        }
        result.success(mCurrentHingeAngle)
      } else {
        result.notImplemented()
      }
    } catch (e: Exception) {
      result.success(false)
    }

  }

  fun setupWindowManager(binding: ActivityPluginBinding) {
    windowManager = WindowManager(binding.activity, null)
    windowManager?.registerDeviceStateChangeCallback(mainThreadExecutor, deviceStateChangeCallback)
  }

  fun teardownWindowManager() {
    windowManager?.unregisterDeviceStateChangeCallback(deviceStateChangeCallback)
    windowManager = null
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    setupWindowManager(binding)
  }

  override fun onDetachedFromActivity() {
    activity = null
    teardownWindowManager()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    setupWindowManager(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
    teardownWindowManager()
  }

  fun isDualScreenDevice(): Boolean? {
    if (activity == null) return null;

    val feature = "com.microsoft.device.display.displaymask"
    val pm = activity!!.packageManager
    return pm.hasSystemFeature(feature)
  }

  fun isAppSpanned(): Boolean? {
    if (activity == null) return null;

    val displayMask = DisplayMask.fromResourcesRectApproximation(activity)
    val boundings = displayMask.boundingRects

    if (boundings.isEmpty()) return false;

    val first = boundings[0]
    val rootView = activity!!.window.decorView.rootView
    val drawingRect = android.graphics.Rect()
    rootView.getDrawingRect(drawingRect)

    return first.intersect(drawingRect)
  }

  fun getNonFunctionalBounds(): NonFunctionalBounds? {
    if (activity == null) return null;

    val displayMask = DisplayMask.fromResourcesRectApproximation(activity)
    val boundings = displayMask.boundingRects

    if (boundings.isEmpty()) return null;

    val first = boundings[0]

    val density: Float = activity!!.resources.displayMetrics.density

    return NonFunctionalBounds(
            top = first.top / density,
            bottom = first.bottom / density,
            left = first.left / density,
            right = first.right / density)
  }

  //todo what to do when SensorManager is null?
  fun setupSensors() {
    mSensorManager = activity!!.getSystemService(SENSOR_SERVICE) as SensorManager?
    val sensorList: List<Sensor> = mSensorManager!!.getSensorList(Sensor.TYPE_ALL)

    for (sensor in sensorList) {
      if (sensor.name.contains(HINGE_ANGLE_SENSOR_NAME)) {
        mHingeAngleSensor = sensor
        break
      }
    }

    mSensorListener = object : SensorEventListener {
      override fun onSensorChanged(event: SensorEvent) {
        if (event.sensor === mHingeAngleSensor) {
          mCurrentHingeAngle = event.values[0]
        }
      }

      override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        //TODO – Add support later
      }
    }

    mSensorManager!!.registerListener(
            mSensorListener,
            mHingeAngleSensor,
            SensorManager.SENSOR_DELAY_NORMAL)

    mSensorsSetup = true
  }

  fun getSurfaceDuoInfoModel() : SurfaceDuoInfoModel? {
    if (activity == null) return null;

    val feature = "com.microsoft.device.display.displaymask"
    val pm = activity!!.packageManager
    val isDualScreenDevice = pm.hasSystemFeature(feature)

    val displayMask = DisplayMask.fromResourcesRectApproximation(activity)
    val boundings = displayMask.boundingRects

    var isSpanned = false;
    var nonFunctionalBounds: NonFunctionalBounds? = null

    if (boundings.isNotEmpty()) {
      val first = boundings[0]
      val rootView = activity!!.window.decorView.rootView
      val drawingRect = android.graphics.Rect()
      rootView.getDrawingRect(drawingRect)
      isSpanned = first.intersect(drawingRect)

      val density: Float = activity!!.resources.displayMetrics.density

      if (isSpanned) {
        nonFunctionalBounds = NonFunctionalBounds(
                top = first.top / density,
                bottom = first.bottom / density,
                left = first.left / density,
                right = first.right / density)
      }
    }

    return SurfaceDuoInfoModel(
            isDualScreenDevice = isDualScreenDevice,
            isSpanned = isSpanned,
            hingeAngle = mCurrentHingeAngle,
            nonFunctionalBounds = nonFunctionalBounds)
  }

  fun getInfoModel() : InfoModel? {
    if (activity == null || windowManager == null) return null;

    val surfaceDuoInfoModel = getSurfaceDuoInfoModel();
    val posture = deviceState?.posture;

    return InfoModel(surfaceDuoInfoModel = surfaceDuoInfoModel, devicePosture = posture)
  }

}

data class NonFunctionalBounds(
        val top: Float,
        val bottom: Float,
        val left: Float,
        val right: Float
)

data class SurfaceDuoInfoModel(
        val isDualScreenDevice: Boolean,
        val isSpanned: Boolean,
        val hingeAngle: Float,
        val nonFunctionalBounds: NonFunctionalBounds?
)

data class InfoModel(
        val surfaceDuoInfoModel: SurfaceDuoInfoModel?,
        val devicePosture: Int?
)
