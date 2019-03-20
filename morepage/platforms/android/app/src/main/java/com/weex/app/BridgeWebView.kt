package com.weex.app

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebSettings
import android.webkit.WebView
import com.github.lzyzsd.jsbridge.BridgeHandler
import com.github.lzyzsd.jsbridge.BridgeWebViewClient
import com.github.lzyzsd.jsbridge.CallBackFunction
import kotlinx.android.synthetic.main.activity_webview.*

class BridgeWebView : AppCompatActivity() {
    private lateinit var url: String

    companion object {
        val KEY_URL = "key_url"
        fun launch(activity: AppCompatActivity, url: String) {
            val intent = Intent(activity, BridgeWebView::class.java)
            intent.putExtra(KEY_URL, url)
            activity.startActivity(intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_webview)
        url = intent.getStringExtra(KEY_URL)
        initWebView()
    }

    private fun initWebView() {
        val webSettings = bridgeWebView.settings
        //设置user-agent
        webSettings.javaScriptEnabled = true
        webSettings.domStorageEnabled = true
        webSettings.setSupportZoom(true)
        // 扩大比例的缩放
        webSettings.useWideViewPort = true
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            webSettings.pluginState = WebSettings.PluginState.ON
            webSettings.allowFileAccessFromFileURLs = true
            webSettings.domStorageEnabled = true
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            //5.0以上https和http混合地址默认异常处理，打开总是允许避免这种情况
            webSettings.mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
        }
        bridgeWebView.webChromeClient = object : WebChromeClient() {
            override fun onReceivedTitle(view: WebView, title: String?) {
                super.onReceivedTitle(view, title)
            }

            override fun onProgressChanged(view: WebView?, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
            }
        }
        bridgeWebView.webViewClient = object : BridgeWebViewClient(bridgeWebView) {
            override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
                return super.shouldOverrideUrlLoading(view, request)
            }

            override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
                return super.shouldOverrideUrlLoading(view, url)
            }
        }
        bridgeWebView.loadUrl(url)
        registerHandle()
    }

    private fun registerHandle() {
        bridgeWebView.registerHandler("shareWeb") { _, callBack: CallBackFunction ->
            callBack.onCallBack("AAAAAA")
            print("asdf")
        }
    }
}