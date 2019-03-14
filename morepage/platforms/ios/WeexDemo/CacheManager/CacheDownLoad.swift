//
//  CacheDownLoad.swift
//  WeexDemo
//
//  Created by Alexluan on 2019/3/13.
//  Copyright © 2019年 taobao. All rights reserved.
//

import UIKit

class CacheDownLoad: NSObject {

    private lazy var session:URLSession = {
        let config = URLSessionConfiguration.default
        let currentSession = URLSession(configuration: config, delegate: self,
                                        delegateQueue: nil)
        return currentSession

    }()

    private let savepath: String
    private let fileName: String

    @objc init(_ savePath: String, fileName: String) {
        self.savepath = savePath
        self.fileName = fileName
    }

    @objc func downLoadFile(url: URL, toPath: String) {
        let request = URLRequest(url: url)
        let downLoadTash = session.downloadTask(with: request)
        downLoadTash.resume()
    }

}

extension CacheDownLoad: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("download success!!!!!  \(location.absoluteString)")
        let locationPath = location.path
        try? FileManager.default.moveItem(at: URL(fileURLWithPath: locationPath), to: URL(fileURLWithPath: self.savepath + "/" + self.fileName))
        print("asdf")
    }

    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("download fail")
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let downFloat = (CGFloat)(bytesWritten)
        let total = (CGFloat)(totalBytesWritten)
        print("loading: \(downFloat / total)")
    }

    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("download success!!!!!")
//        //下载结束
//        print("下载结束")
//
//        //输出下载文件原来的存放目录
//        print("location:\(location)")
//        //location位置转换
//        let locationPath = location.path
//        //拷贝到用户目录
//        let documnets:String = NSHomeDirectory() + "/Documents/2.png"
//        //创建文件管理器
//        let fileManager = FileManager.default
//        try! fileManager.moveItem(atPath: locationPath, toPath: documnets)
//        print("new location:\(documnets)")
    }
}
