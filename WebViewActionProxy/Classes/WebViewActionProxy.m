//
//  WebViewActionProxy.m
//  WebViewActionProxy
//
//  email：chongyangfly@163.com
//  QQ：1909295866
//  github：https://github.com/wangcy90
//  blog：http://wangcy90.github.io
//
//  Created by WangChongyang on 16/6/29.
//  Copyright © 2016年 WangChongyang. All rights reserved.
//

#import "WebViewActionProxy.h"

@interface WebViewActionProxy()

@property (strong, nonatomic)JSContext *context;

@end

@implementation WebViewActionProxy

- (void)bindObject:(id)object toJSExportKey:(NSString *)native {
    self.context[native] = object;
}

- (void)callJSMethod:(NSString *)JSMethod arguments:(NSArray *)arguments {
    
    if (self.context && JSMethod && JSMethod.length) {
        [self.context[JSMethod] callWithArguments:arguments];
    }
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [_webViewProxyDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_webViewProxyDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    if ([_proxyDelegate respondsToSelector:@selector(proxy:didFinishLoad:context:)]) {
        [_proxyDelegate proxy:self didFinishLoad:webView context:self.context];
    }
    
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_webViewProxyDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [_webViewProxyDelegate webView:webView didFailLoadWithError:error];
    }
}

@end
