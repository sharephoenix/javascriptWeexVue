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

@interface WKWebComponent()<WKUIDelegate, WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@property (nonatomic, strong, strong) NSString *url;
@property (nonatomic, strong) NSString *inInitsource;
@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) BOOL startLoadEvent;
@property (nonatomic, assign) BOOL finishLoadEvent;
@property (nonatomic, assign) BOOL failLoadEvent;

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
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    return webView;
}

- (void)viewDidLoad {
    _webView = (WKWebView *)self.view;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    // 处理 WKWebView 的初始化的一些东西
    self.source = _inInitsource;
    if (_url) {
        [self loadURL:_url];
    }
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

- (NSMutableDictionary<NSString *, id> *)baseInfo
{
    NSMutableDictionary<NSString *, id> *info = [NSMutableDictionary new];
    [info setObject:[self.webView URL].absoluteURL ?: @"" forKey:@"url"];
//    [info setObject:[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"] ?: @"" forKey:@"title"];
    [info setObject:@(self.webView.canGoBack) forKey:@"canGoBack"];
    [info setObject:@(self.webView.canGoForward) forKey:@"canGoForward"];
    return info;
}
@end
