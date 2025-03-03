package com.example.app_template

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import io.flutter.embedding.android.FlutterActivity

class SplashActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.launch_screen)

        val handler = Handler()
        handler.postDelayed({
            val intent = Intent(this@SplashActivity, MainActivity::class.java)
            startActivity(intent)
            finish()
        }, 3000)
    }
}

