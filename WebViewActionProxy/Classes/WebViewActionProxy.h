//
//  WebViewActionProxy.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class WebViewActionProxy;

@protocol WebViewActionProxyDelegate <NSObject>

@optional

- (void)proxy:(WebViewActionProxy *)proxy didFinishLoad:(UIWebView *)webView context:(JSContext *)context;

@end

@interface WebViewActionProxy : NSObject<UIWebViewDelegate>

@property(nonatomic,weak)id<UIWebViewDelegate>webViewProxyDelegate;

@property(nonatomic,weak)id<WebViewActionProxyDelegate>proxyDelegate;

- (void)bindObject:(id)object toJSExportKey:(NSString *)native;//bind an object to js when webView finish load

- (void)callJSMethod:(NSString *)JSMethod arguments:(NSArray *)arguments;//native call js function

@end
