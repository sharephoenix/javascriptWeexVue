package com.weex.app.components;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.net.Uri;
import android.net.http.SslError;
import android.nfc.Tag;
import android.os.Build;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.JsPromptResult;
import android.webkit.SslErrorHandler;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;
import android.widget.ProgressBar;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.github.lzyzsd.jsbridge.BridgeHandler;
import com.github.lzyzsd.jsbridge.BridgeWebView;
import com.github.lzyzsd.jsbridge.CallBackFunction;
import com.taobao.weex.ui.view.IWebView;
import com.taobao.weex.utils.WXLogUtils;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

public class WXKWebView implements IWebView {

    private Context mContext;
    private String mOrigin;
    public BridgeWebView mWebView;
    private ProgressBar mProgressBar;
    private boolean mShowLoading = true;
    private Handler mMessageHandler;
    private static final int POST_MESSAGE = 1;
    private static final String BRIDGE_NAME = "__WEEX_WEB_VIEW_BRIDGE";
    private static final int SDK_VERSION = Build.VERSION.SDK_INT;


    // downgraded by CVE-2012-6636(https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2012-6636)
    private static final boolean DOWNGRADE_JS_INTERFACE = SDK_VERSION < 17;

    private OnErrorListener mOnErrorListener;
    private OnPageListener mOnPageListener;
    private OnMessageListener mOnMessageListener;

    public WXKWebView(Context context, String origin) {
        mContext = context;
        mOrigin = origin;
    }

    @Override
    public View getView() {
        FrameLayout root = new FrameLayout(mContext);
        root.setBackgroundColor(Color.WHITE);

        mWebView = new BridgeWebView(mContext);//mContext.getApplicationContext();
        FrameLayout.LayoutParams wvLayoutParams =
                new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,
                        FrameLayout.LayoutParams.MATCH_PARENT);
        wvLayoutParams.gravity = Gravity.CENTER;
        mWebView.setLayoutParams(wvLayoutParams);
        root.addView(mWebView);
        initWebView(mWebView);

        mProgressBar = new ProgressBar(mContext);
        showProgressBar(false);
        FrameLayout.LayoutParams pLayoutParams =
                new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT,
                        FrameLayout.LayoutParams.WRAP_CONTENT);
        mProgressBar.setLayoutParams(pLayoutParams);
        pLayoutParams.gravity = Gravity.CENTER;
        root.addView(mProgressBar);

        this.registHandlers();
        return root;
    }

    private void registHandlers() {
        mWebView.registerHandler("scanClick", new BridgeHandler() {
            @Override
            public void handler(String data, CallBackFunction function) {
                Log.d("Tag", "message");
            }
        });
    }

    @Override
    public void destroy() {
        if (getWebView() != null) {
            getWebView().removeAllViews();
            getWebView().destroy();
            mWebView = null;
        }
    }

    @Override
    public void loadUrl(String url) {
        if(getWebView() == null)
            return;
        getWebView().loadUrl(url);
    }

    @Override
    public void loadDataWithBaseURL(String source) {
        if(getWebView() == null)
            return;
        getWebView().loadDataWithBaseURL(mOrigin, source, "text/html", "utf-8", null);
    }

    @Override
    public void reload() {
        if(getWebView() == null)
            return;
        getWebView().reload();
    }

    @Override
    public void goBack() {
        if(getWebView() == null)
            return;
        getWebView().goBack();
    }

    @Override
    public void goForward() {
        if(getWebView() == null)
            return;
        getWebView().goForward();
    }

    @Override
    public void postMessage(Object msg) {
        if (getWebView() == null) return;
        mWebView.callHandler("testJavaScriptFunction","test", new CallBackFunction() {
            @Override
            public void onCallBack(String data) {
                Log.e("TAG", "来自web的回传数据：" + data);
            }
        });
    }

    /*@Override
    public void setVisibility(int visibility) {
        if (mRootView != null) {
            mRootView.setVisibility(visibility);
        }
    }*/

    @Override
    public void setShowLoading(boolean shown) {
        mShowLoading = shown;
    }

    @Override
    public void setOnErrorListener(OnErrorListener listener) {
        mOnErrorListener = listener;
    }

    @Override
    public void setOnPageListener(OnPageListener listener) {
        mOnPageListener = listener;
    }

    @Override
    public void setOnMessageListener(OnMessageListener listener) {
        mOnMessageListener = listener;
    }

    private void showProgressBar(boolean shown) {
        if (mShowLoading) {
            mProgressBar.setVisibility(shown ? View.VISIBLE : View.GONE);
        }
    }

    private void showWebView(boolean shown) {
        mWebView.setVisibility(shown ? View.VISIBLE : View.INVISIBLE);
    }

    private @Nullable
    WebView getWebView() {
        //TODO: remove this, duplicate with getView semantically.
        return mWebView;
    }

    private void initWebView(WebView wv) {
        WebSettings settings = wv.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setAppCacheEnabled(true);
        settings.setUseWideViewPort(true);
        settings.setDomStorageEnabled(true);
        settings.setSupportZoom(false);
        settings.setBuiltInZoomControls(false);
        settings.setAllowFileAccess(false);
        wv.setWebViewClient(new WebViewClient() {

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                WXLogUtils.v("tag", "onPageOverride " + url);
                return true;
            }

            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
                WXLogUtils.v("tag", "onPageStarted " + url);
                if (mOnPageListener != null) {
                    mOnPageListener.onPageStart(url);
                }
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                WXLogUtils.v("tag", "onPageFinished " + url);
                if (mOnPageListener != null) {
                    mOnPageListener.onPageFinish(url, view.canGoBack(), view.canGoForward());
                }
                if (mOnMessageListener != null) {
                    evaluateJS("javascript:(window.postMessage = function(message, targetOrigin) {"
                            + "if (message == null || !targetOrigin) return;"
                            + (DOWNGRADE_JS_INTERFACE
                            ? "prompt('" + BRIDGE_NAME + "://postMessage?message=' + JSON.stringify(message) + '&targetOrigin=' + targetOrigin)"
                            : BRIDGE_NAME + ".postMessage(JSON.stringify(message), targetOrigin);")
                            + "})");
                }
            }

            @Override
            public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
                super.onReceivedError(view, request, error);
                if (mOnErrorListener != null) {
                    //mOnErrorListener.onError("error", "page error code:" + error.getErrorCode() + ", desc:" + error.getDescription() + ", url:" + request.getUrl());
                    mOnErrorListener.onError("error", "page error");
                }
            }

            @Override
            public void onReceivedHttpError(WebView view, WebResourceRequest request, WebResourceResponse errorResponse) {
                super.onReceivedHttpError(view, request, errorResponse);
                if (mOnErrorListener != null) {
                    mOnErrorListener.onError("error", "http error");
                }
            }

            @Override
            public void onReceivedSslError(WebView view, SslErrorHandler handler, SslError error) {
                super.onReceivedSslError(view, handler, error);
                if (mOnErrorListener != null) {
                    mOnErrorListener.onError("error", "ssl error");
                }
            }
        });
        wv.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                super.onProgressChanged(view, newProgress);
                showWebView(newProgress == 100);
                showProgressBar(newProgress != 100);
                WXLogUtils.v("tag", "onPageProgressChanged " + newProgress);
            }

            @Override
            public void onReceivedTitle(WebView view, String title) {
                super.onReceivedTitle(view, title);
                if (mOnPageListener != null) {
                    mOnPageListener.onReceivedTitle(view.getTitle());
                }
            }

            @Override
            public boolean onJsPrompt(WebView view, String url, String text, String defaultValue, JsPromptResult result) {
                Uri uri = Uri.parse(text);
                String scheme = uri.getScheme();
                if (TextUtils.equals(scheme, BRIDGE_NAME)) {
                    if (TextUtils.equals(uri.getAuthority(), "postMessage")) {
                        String message = uri.getQueryParameter("message");
                        String targetOrigin = uri.getQueryParameter("targetOrigin");
                        onMessage(message, targetOrigin);
                        result.confirm("success");
                    } else {
                        result.confirm("fail");
                    }
                    return true;
                }
                return super.onJsPrompt(view, url, text, defaultValue, result);
            }
        });
        if (!DOWNGRADE_JS_INTERFACE) {
            wv.addJavascriptInterface(new Object() {
                @JavascriptInterface
                public void postMessage(String message, String targetOrigin) {
                    onMessage(message, targetOrigin);
                }
            }, BRIDGE_NAME);
        }
    }

    private void onMessage(String message, String targetOrigin) {
        if (message != null && targetOrigin != null && mOnMessageListener != null) {
            try {
                Map<String, Object> initData = new HashMap<>();
                initData.put("data", JSON.parse(message));
                initData.put("origin", targetOrigin);
                initData.put("type", "message");
                Message threadMessage = new Message();
                threadMessage.what = POST_MESSAGE;
                threadMessage.obj = initData;
//                mMessageHandler.sendMessage(threadMessage);
            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private void evaluateJS(String jsStr) {
        if (SDK_VERSION < 19) {
            mWebView.loadUrl(jsStr);
        } else {
            mWebView.evaluateJavascript(jsStr, null);
        }
    }

}
