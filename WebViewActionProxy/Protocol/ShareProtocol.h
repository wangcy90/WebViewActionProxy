//
//  ShareProtocol.h
//  WebViewActionProxy
//
//  email：chongyangfly@163.com
//  QQ：1909295866
//  github：https://github.com/wangcy90
//  blog：http://wangcy90.github.io
//
//  Created by WangChongyang on 16/6/30.
//  Copyright © 2016年 WangChongyang. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@protocol ShareProtocol <JSExport>

/**
 *  JSExportAs is a macro
 *
 *  @param functionNameForJS   js代码中的回调方法的别名
 *  @param shareText 需要回掉的native方法名
 */
JSExportAs(functionNameForJS,- (void)shareWithTitle:(NSString *)title message:(NSString *)message);

- (void)shareText:(NSString *)title;

@end
