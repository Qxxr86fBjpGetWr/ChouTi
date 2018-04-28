# NIM iOS SDK Lite
[网易云信](http://netease.im)是由网易发布的一款 IM 云服务产品。此仓库是云信 iOS SDK 精简版本的发布仓库。

## 使用方法
* 通过  [release](https://github.com/netease-im/NIM_iOS_SDK_Lite/releases) 下载相应 SDK 包

* 使用 'pod NIMSDK_LITE'。

## 目录结构
* SDK
  * ExportHeaders       (导出头文件
  * Libs                （依赖第三方库文件
  * libNIMSDK.a         (NIM SDK 静态库文件

## 差异
精简版和完整版本的最大差异在于精简版去除了音视频相关的模块，包括音视频聊天，白板教学等模块，仅提供 IM 相关的功能，适合于只需要接入 IM 模块的产品，避免因音视频模块而带来不必要的包大小的增长。
