//
//  AlertMessageProtocol.h
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

@protocol AlertMessageProtocol <JSExport>

- (void)showAlertWithMessage:(NSString *)message;

@end
