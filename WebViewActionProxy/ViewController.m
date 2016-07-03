//
//  ViewController.m
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

#import "ViewController.h"
#import "WebViewActionProxy.h"
#import "ShareProtocol.h"
#import "AlertMessageProtocol.h"

@interface ViewController ()<WebViewActionProxyDelegate,UIWebViewDelegate,ShareProtocol,AlertMessageProtocol> {
    WebViewActionProxy *_webViewProxy;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webViewProxy = [WebViewActionProxy new];
    
    _webViewProxy.proxyDelegate = self;
    
    _webViewProxy.webViewProxyDelegate = self;
    
    _webView.delegate = _webViewProxy;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"didFailLoadWithError");
}

#pragma mark - WebViewActionProxyDelegate

- (void)proxy:(WebViewActionProxy *)proxy didFinishLoad:(UIWebView *)webView context:(JSContext *)context {
    NSLog(@"proxyDidFinishLoad");
    [proxy bindObject:self toJSExportKey:@"native"];
}

#pragma mark - target actions

- (IBAction)back:(id)sender {
    
    if (_webView.canGoBack) {
        [_webView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - ShareProtocol

- (void)shareText:(NSString *)text {
    NSLog(@"shareText---->%@",text);
    [_webViewProxy callJSMethod:@"showResult" arguments:@[text]];
}

- (void)shareWithTitle:(NSString *)title message:(NSString *)message {
    NSLog(@"shareWithTitle -----> title:%@,message:%@",title,message);
}

#pragma mark - AlertMessageProtocol

- (void)showAlertWithMessage:(NSString *)message {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    });
    
}

@end
