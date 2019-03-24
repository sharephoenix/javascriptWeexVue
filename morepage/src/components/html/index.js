window.setupWebViewJavascriptBridge=function (callback) {
        let u = navigator.userAgent
        let isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1
        let isiOS = !!u.match(/\(i[^;]+;(U;)? CPU.+Mac OS X/)

        if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge) }
        if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback) }
        window.WVJBCallbacks = [callback]
        var WVJBIframe = document.createElement('iframe')
        WVJBIframe.style.display = 'none'
        
        if (isAndroid) {
          WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__'
        } else if (isiOS) {
          WVJBIframe.src = 'https://__BRIDGE_LOADED__'
        }
        document.documentElement.appendChild(WVJBIframe)
        setTimeout(function () { document.documentElement.removeChild(WVJBIframe) }, 0)
      }


setupWebViewJavascriptBridge(function(bridge){
  bridge.registerHandler('testJavaScriptFunction',function(data,responseCallback){
    alert('原生调用了js')
    var responseData = { 'Javascript Says':'Right back atcha!' }
    responseCallback(responseData)
  })
})


function customaction() {
  document.getElementById("returnValue").value = "方法被调用了";

  alert('asdfasdf' + window.WebViewJavascriptBridge);
  // document.getElementById("returnValue").value = "asdfasdf";
  WebViewJavascriptBridge.callHandler('shareWeb', {event: 'voice'},function(dataFromOC){
    document.getElementById("returnValue").value = "方法调用返回成功";
  });   
}

