//
//  WKWebComponent.m
//  WeexDemo
//
//  Created by phoenix on 2019/3/15.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "WKWebComponent.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge.h>

@interface WKWebComponent()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;

@property (nonatomic, strong, strong) NSString *url;
@property (nonatomic, strong) NSString *inInitsource;
@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) BOOL startLoadEvent;
@property (nonatomic, assign) BOOL finishLoadEvent;
@property (nonatomic, assign) BOOL failLoadEvent;

@property (nonatomic, strong) WebViewJavascriptBridge *jsBridge;

@end

@implementation WKWebComponent
WX_EXPORT_METHOD(@selector(postMessage:))
WX_EXPORT_METHOD(@selector(goBack))
WX_EXPORT_METHOD(@selector(reload))
WX_EXPORT_METHOD(@selector(goForward))

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance {
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        self.url = attributes[@"src"];
        if (attributes[@"source"]) {
            self.inInitsource = attributes[@"source"];
        }
    }
    return self;
}

- (UIView *)loadView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc]init];
    config.preferences = preference;
    [config.preferences setValue:@(YES) forKey:@"allowFileAccessFromFileURLs"];
    //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
    preference.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];  //交互的重要之点
    [userContentController addScriptMessageHandler:self name:@"message"];
    config.userContentController = userContentController;

    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    return webView;
}

- (void)viewDidLoad {
    [self clearCache];
    _webView = (WKWebView *)self.view;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    // js native 交互
    _jsBridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    
    [self registBridge];
//    WebViewJavascriptBridge.enableLogging()
    [WebViewJavascriptBridge enableLogging];

    // 处理 WKWebView 的初始化的一些东西
    self.source = _inInitsource;
    if (_url) {
        [self loadURL:_url];
    }


}

- (void)registBridge {
    [_jsBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"dataFrom JS : %@",data[@"data"]);

        responseCallback(@"扫描结果 : www.baidu.com");
    }];

    [_jsBridge registerHandler:@"shareWeb" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"dataFrom JS : %@",data[@"data"]);

        responseCallback(@"扫描结果 : www.baidu.com");
    }];

}

- (void)updateAttributes:(NSDictionary *)attributes {
    if (attributes[@"src"]) {
        self.url = attributes[@"src"];
    }

    if (attributes[@"source"]) {
        self.inInitsource = attributes[@"source"];
        self.source = self.inInitsource;
    }
}

- (void)addEvent:(NSString *)eventName {
    if ([eventName isEqualToString:@"pagestart"]) {
        _startLoadEvent = YES;
    }
    else if ([eventName isEqualToString:@"pagefinish"]) {
        _finishLoadEvent = YES;
    }
    else if ([eventName isEqualToString:@"error"]) {
        _failLoadEvent = YES;
    }
}

- (void)setUrl:(NSString *)url
{
    NSString* newURL = [url copy];
    WX_REWRITE_URL(url, WXResourceTypeLink, self.weexInstance)
    if (!newURL) {
        return;
    }

    if (![newURL isEqualToString:_url]) {
        _url = newURL;
        if (_url) {
            [self loadURL:_url];
        }
    }
}

- (void) setSource:(NSString *)source
{
    NSString *newSource=[source copy];
    if(!newSource || _url){
        return;
    }
    if(![newSource isEqualToString:_source]){
        _source=newSource;
        if(_source){
            [_webView loadHTMLString:_source baseURL:nil];
        }
    }

}

- (void)loadURL:(NSString *)url {
    if (self.webView) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}

- (void)reload {
    [self.webView reload];
}

- (void)goBack {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)goForward {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

// Weex postMessage to web
- (void)postMessage:(NSDictionary *)data {
//    [_jsBridge callHandler:@"changeBGColor" data:@"传递给 JS 的参数" responseCallback:^(id responseData) {
//        NSLog(@"JS 的返回值: %@",responseData);
//    }];

    [_jsBridge callHandler:@"updateStatus" data:@"传递给 JS 的参数" responseCallback:^(id responseData) {
        NSLog(@"JS 的返回值: %@",responseData);
    }];
//    [_jsBridge callHandler:@"testJavaScriptFunction"];

//    [_jsBridge callHandler:@"changeBGColor"];
//    [_jsBridge callHandler:@"changeBGColor" data:@"把 HTML 的背景颜色改成橙色!!!!"];

//    WXSDKInstance *instance = [WXSDKEngine topInstance];
//
//    NSString *bundleUrlOrigin = @"";
//
//    if (instance.pageName) {
//        NSString *bundleUrl = [instance.scriptURL absoluteString];
//        NSURL *url = [NSURL URLWithString:bundleUrl];
//        bundleUrlOrigin = [NSString stringWithFormat:@"%@://%@%@", url.scheme, url.host, url.port ? [NSString stringWithFormat:@":%@", url.port] : @""];
//    }
//
//    NSDictionary *initDic = @{
//                              @"type" : @"message",
//                              @"data" : data,
//                              @"origin" : bundleUrlOrigin
//                              };
//
//    NSString *json = [WXUtility JSONString:initDic];
//    NSString *code = [NSString stringWithFormat:@"(function (){window.dispatchEvent(new MessageEvent('message', %@));}())", json];
//    [self.webView evaluateJavaScript:code completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//        NSLog(@"%@----%@",result, error);
//    }];
}

#pragma mark -delegate

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {

}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {

}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    if (_finishLoadEvent) {
        // 网页中的信息
        NSDictionary *data = [self baseInfo];
        [self fireEvent:@"pagefinish" params:data domChanges:@{@"attrs": @{@"src":[self.webView URL].absoluteURL}}];
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}


- (NSMutableDictionary<NSString *, id> *)baseInfo
{
    NSMutableDictionary<NSString *, id> *info = [NSMutableDictionary new];
    [info setObject:self.webView.URL.absoluteString forKey:@"url"];
    [info setObject:self.webView.title forKey:@"title"];
    [info setObject:@(self.webView.canGoBack) forKey:@"canGoBack"];
    [info setObject:@(self.webView.canGoForward) forKey:@"canGoForward"];
    return info;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"execute::::%@", message.name);
}

- (void)clearCache {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    }];
}

- (void)dealloc {
    [self clearCache];
}
@end
