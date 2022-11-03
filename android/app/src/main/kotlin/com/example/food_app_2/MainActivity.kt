package com.kb.shoppingAPP

import android.Manifest
import android.Manifest.permission.*
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.wifi.hotspot2.pps.Credential
import android.os.Build
import android.os.Bundle
import android.telephony.TelephonyManager
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import com.google.android.gms.auth.api.credentials.Credentials
import com.google.android.gms.auth.api.credentials.CredentialsOptions
import com.google.android.gms.auth.api.credentials.HintRequest
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    var phoneNumber: String? = null

    // Function will run after click to button
    fun GetNumber() {
        if (ActivityCompat.checkSelfPermission(this, READ_SMS) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, READ_PHONE_NUMBERS) ==
                PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this,
                        READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
            // Permission check

            // Create obj of TelephonyManager and ask for current telephone service
            val telephonyManager = this.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            phoneNumber = telephonyManager.line1Number

            return
        } else {
            // Ask for permission
            requestPermission()
        }
    }

    private fun requestPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(arrayOf(READ_SMS, READ_PHONE_NUMBERS, READ_PHONE_STATE), 100)
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            100 -> {
                val telephonyManager = this.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                if (ActivityCompat.checkSelfPermission(this, READ_SMS) !=
                        PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this,
                                READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                    return
                }
                phoneNumber = telephonyManager.line1Number

            }
            else -> throw IllegalStateException("Unexpected value: $requestCode")
        }
    }


    private val CHANNEL = "com.kb.ShoppingApp"
    private lateinit var channel: MethodChannel

//    private fun getMobileNumber(): String {
//        val tm = getSystemService(TELEPHONY_SERVICE)
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
//            return
//        }
//        return ""
//    }

//    private fun getPhoneNumber() {
//        var request = HintRequest.Builder().setPhoneNumberIdentifierSupported(true).build()
//        val option = CredentialsOptions.Builder().forceEnableSaveDialog().build()
//        val crend_client = Credentials.getClient(applicationContext, option)
//        val intent = crend_client.getHintPickerIntent(request)
//        startIntentSenderForResult(intent.intentSender, 2002, null, 0, 0, 0, Bundle())
//    }

//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
//        super.onActivityResult(requestCode, resultCode, data)
//        if (requestCode == 2002 && resultCode == RESULT_OK) {
//            val cred: Credential? = data?.getParcelableExtra(com.google.android.gms.auth.api.credentials.Credential.EXTRA_KEY)
//            print(cred)
//        } else if (requestCode == 11012) {
//            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_SMS) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
//                return
//            }
//            Toast.makeText(applicationContext, tm.voiceMailNumber, Toast.LENGTH_SHORT).show()
//        } else {
//            Toast.makeText(applicationContext, "No Phone Found", Toast.LENGTH_SHORT).show()
//        }
//    }

    @RequiresApi(Build.VERSION_CODES.P)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "getMobileNumber") {
//                val data = getMobileNumber()
//                result.success(data)
                GetNumber()
                (call.arguments as String?)?.let {
                    result.success(phoneNumber)
                }
            }
        }
    }

}
