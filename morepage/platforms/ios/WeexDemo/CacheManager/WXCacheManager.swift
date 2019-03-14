//
//  WXCacheManager.swift
//  WeexDemo
//
//  Created by Alexluan on 2019/3/13.
//  Copyright © 2019年 taobao. All rights reserved.
//

import UIKit

@objc class WXCacheManager: NSObject {

    @objc static let instance = WXCacheManager()

    private let cacheRootPath = "weexapps"
    private let configName = "config.plist"

    private override init() {

    }

    @objc func getInstance() -> WXCacheManager {
        return WXCacheManager.instance
    }

    // 保存配置文件
    private func saveConfig(_ config: [String: String], appId: String) -> Bool {
        guard let appPath = getAppPath(appId) else { return false }
        let configPath = appPath + "/" + configName
        return (config as NSDictionary).write(toFile: configPath, atomically: true)
    }

    // 获取 app 的根目录文件夹
    @objc func getRootPath() -> String? {
        var rootPath = ""
        let fileManager = FileManager.default
        let homeDirectionary = NSHomeDirectory()
        rootPath = homeDirectionary + "/" + "Documents" + "/" + cacheRootPath
        if !fileManager.fileExists(atPath: rootPath) {
            try! fileManager.createDirectory(atPath: rootPath, withIntermediateDirectories: true, attributes: nil)
        }
        return rootPath
    }

    // 过去 app 路径
    @objc func getAppPath(_ appId: String) -> String? {
        guard let rootPath = getRootPath() else {
            return nil
        }
        let appPath = rootPath + "/" + appId
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: appPath) {
            try! fileManager.createDirectory(atPath: appPath, withIntermediateDirectories: true, attributes: nil)
        }
        return appPath
    }

}
