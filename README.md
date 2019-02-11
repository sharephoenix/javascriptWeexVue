# javascriptWeexVue
## http://weex.apache.org/cn/guide/
# WeexInstall
## 确保 weex-toolkit 为新版本
    npm install -g weex-toolkit@latest
## 创建工程
    weex create your_project
## 安装 weex-ui
    npm i weex-ui@latest -S
## 安装依赖
    npm install
## 运行项目
    npm run start // 启动项目
## 添加工程模板
    weex platform add ios
    weex platform add android
## 运行模板
    weex run ios
    weex run android
## 数据缓存 注意：说是缓存的数据要在 5M 一下
	const storage = weex.requireModule('storage')

## 方法 相互调用 (module, handle, component)
    1. component 用作 主键封装 可以把类封装成，类似于 div 组件
    2. https://weex-project.io/cn/guide/extend-ios.html

# js 调用 navtive 方法
##  native 类名和方法实现：
1. 创建EventModule AQXEventModule<WXEventModuleProtocol, WXModuleProtocol>
    #import <WeexSDK/WXEventModuleProtocol.h>
    #import <WeexSDK/WXModuleProtocol.h>
2. 在 AQXEventModule 中时间相应方法
3. @synthesize weexInstance;
    WX_EXPORT_METHOD(@selector(weexSay:))
    WX_EXPORT_METHOD(@selector(callbacktest:))
    - (void)weexSay:(NSString *)string
    {
        NSLog(@"js invoke native weexSay:%@",string);
    }
##  js 调用
1. weex.requireModule("event").weexSay("fixtestfixtestfixtest")

