window.setupWebViewJavascriptBridge=function (callback) {
    let u = navigator.userAgent
    let isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1
    let isiOS = !!u.match(/\(i[^;]+;(U;)? CPU.+Mac OS X/)

    if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge) }
    if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback) }
    window.WVJBCallbacks = [callback]
    var WVJBIframe = document.createElement('iframe')
    WVJBIframe.style.display = 'none'
    
    // if (isAndroid) {
    //   WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__'
    // } else if (isiOS) {
      WVJBIframe.src = 'https://__BRIDGE_LOADED__'
    // }
    document.documentElement.appendChild(WVJBIframe)
    setTimeout(function () { document.documentElement.removeChild(WVJBIframe) }, 0)
  }

  setupWebViewJavascriptBridge(function(bridge){
    bridge.registerHandler('testJavaScriptFunction',function(data,responseCallback){
      alert(data);
      var responseData = { 'Javascript Says':'Right back atcha!' }
      responseCallback(responseData)
    })
  })

function shareClick() {
    alert('tesddt');
    // JS 单纯的调用 OC 的 block
    console.log('asdfasdf');
    alert(JSON.stringify(WebViewJavascriptBridge))
    WebViewJavascriptBridge.callHandler('scanClick');

    // // JS 调用 OC 的 block，并传递 JS 参数
    // WebViewJavascriptBridge.callHandler('scanClick',"JS 参数");

    // // JS 调用 OC 的 block，传递 JS 参数，并接受 OC 的返回值。
    // WebViewJavascriptBridge.callHandler('scanClick',{data : "这是 JS 传递到 OC 的扫描数据"},function(dataFromOC){
    //     alert("JS 调用了 OC 的扫描方法!");
    //     document.getElementById("returnValue").value = dataFromOC;
    // });
}

