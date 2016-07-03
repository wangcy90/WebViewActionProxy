# WebViewActionProxy

一个iOS端webView与native互相调用的解决方案

## 简介

- 见名知义，是作为UIWebView的一个中间代理层
- 该项目依赖JavaScriptCore.framework
-  public api见下图
![WebViewActionProxy][image-1]

## Installation &nbsp;安装
将WebViewActionProxy拖入项目并导入javascriptCore.framework即可使用

## Usage &nbsp;用法

- 实例化后需要设置两个代理
- 同时需要将webView的代理设置为proxy对象
- 见下图


![WebViewActionProxy][image-2]

- webViewProxy对象有一个协议方法


![WebViewActionProxy][image-3]

- 该方法中会抛出proxy对象，当前webView，以及JSContext对象，在该方法中可以直接使用context进行操作，当然也可以使用proxy提供的实例方法进行操作
- 如下图，使用bindObject方法将与web端约定好的调用native对象的key建立映射，之后我们可以通过callJSMethod方法进行native调用js端方法


![WebViewActionProxy][image-4]

- web端要调用native的方法需要借助于JavaScriptCore.framework的JSExport协议，例如：

![WebViewActionProxy][image-5]

- 通过继承JSExport协议，很方便的让JavaScript能够访问和操作Objective-C对象
- 自定义的JSExport协议需要在js与native映射的对象中实现，例如：


![WebViewActionProxy][image-6]
- 在js调用native的方法中我们需要保证线程安全，否则会出异常
- js端实现举例：


![WebViewActionProxy][image-7]

__详细请看Demo__

## License
WebViewActionProxy is provided under the MIT license. See LICENSE file for details.

[image-1]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image.png
[image-2]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image1.png
[image-3]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image2.png
[image-4]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image3.png
[image-5]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image4.png
[image-6]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image5.png
[image-7]:	https://github.com/wangcy90/WebViewActionProxy/blob/master/images/image6.png