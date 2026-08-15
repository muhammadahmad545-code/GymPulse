package com.gympulse.app

import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.StatFs
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private val channelName = "com.gympulse.app/updates"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "inspectApk" -> inspectApk(call.argument("path"), result)
                    "installApk" -> installApk(call.argument("path"), result)
                    "canRequestInstalls" -> result.success(canRequestInstalls())
                    "openInstallPermissionSettings" -> {
                        openInstallPermissionSettings()
                        result.success(null)
                    }
                    "freeBytes" -> freeBytes(call.argument("path"), result)
                    else -> result.notImplemented()
                }
            }
    }

    private fun inspectApk(path: String?, result: MethodChannel.Result) {
        if (path.isNullOrBlank()) {
            result.error("UPDATE_INTEGRITY_FAILED", "Missing APK path.", null)
            return
        }
        val info = packageInfoForArchive(path)
        if (info?.applicationInfo == null || info.packageName.isNullOrBlank()) {
            result.error("UPDATE_INTEGRITY_FAILED", "Unreadable APK.", null)
            return
        }
        result.success(
            mapOf(
                "packageName" to info.packageName,
                "versionCode" to versionCodeOf(info),
                "versionName" to (info.versionName ?: ""),
            ),
        )
    }

    private fun installApk(path: String?, result: MethodChannel.Result) {
        if (path.isNullOrBlank()) {
            result.error("UPDATE_INSTALL_FAILED", "Missing APK path.", null)
            return
        }
        if (!canRequestInstalls()) {
            openInstallPermissionSettings()
            result.error(
                "UPDATE_PERMISSION_REQUIRED",
                "Install permission is required.",
                null,
            )
            return
        }
        val file = File(path)
        if (!file.exists()) {
            result.error("UPDATE_INTEGRITY_FAILED", "APK is no longer available.", null)
            return
        }
        try {
            val uri = FileProvider.getUriForFile(
                this,
                "$packageName.fileprovider",
                file,
            )
            val intent = Intent(Intent.ACTION_VIEW).apply {
                setDataAndType(uri, "application/vnd.android.package-archive")
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            startActivity(intent)
            result.success(null)
        } catch (error: Exception) {
            result.error("UPDATE_INSTALL_FAILED", error.message, null)
        }
    }

    private fun canRequestInstalls(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            packageManager.canRequestPackageInstalls()
        } else {
            true
        }
    }

    private fun openInstallPermissionSettings() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val intent = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES).apply {
                data = Uri.parse("package:$packageName")
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            startActivity(intent)
        }
    }

    private fun freeBytes(path: String?, result: MethodChannel.Result) {
        try {
            val target = if (path.isNullOrBlank()) cacheDir.path else path
            result.success(StatFs(target).availableBytes)
        } catch (_: Exception) {
            result.success(0L)
        }
    }

    private fun packageInfoForArchive(path: String): PackageInfo? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            packageManager.getPackageArchiveInfo(
                path,
                PackageManager.PackageInfoFlags.of(0),
            )
        } else {
            @Suppress("DEPRECATION")
            packageManager.getPackageArchiveInfo(path, 0)
        }
    }

    private fun versionCodeOf(info: PackageInfo): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            info.longVersionCode
        } else {
            @Suppress("DEPRECATION")
            info.versionCode.toLong()
        }
    }
}
