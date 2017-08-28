//
//  SocketManager.swift
//  MouseMoveReceiver
//
//  Created by cmlab on 2017/08/24.
//  Copyright © 2017年 cmlab. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

class SocketManager: NSObject, GCDAsyncUdpSocketDelegate {
    var vc: ViewController
    let PORT = 9900 // port number for the socket
    fileprivate var _socket: GCDAsyncUdpSocket?
    
    init(withViewController vc: ViewController) {
        self.vc = vc
    }

    fileprivate var socket: GCDAsyncUdpSocket? {
        get {
            if _socket == nil {
                _socket = getNewSocket()
            }
            return _socket
        }
        set {
            if _socket != nil {
                _socket?.close()
            }
            _socket = newValue
        }
    }
    
    fileprivate func getNewSocket() -> GCDAsyncUdpSocket? {
        let port = UInt16(PORT)
        let sock = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try sock.bind(toPort: port)
            try sock.enableBroadcast(true)
        } catch _ as NSError {
            NSLog(">>>Issue with setting up listener")
            return nil
        }
        return sock
    }
    
    func startServer() {
        do {
            try socket?.beginReceiving()
        } catch _ as NSError {
            NSLog("Issue starting listener")
            return
        }
        NSLog(">> Server started")
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        if let str = String(bytes: data, encoding: String.Encoding.ascii) {
            NSLog("Received: \(str)")
            let split1 = str.components(separatedBy: "[/p]")
            let split2 = split1[0].components(separatedBy: "|")
            vc.scrollBy(dx: Int(split2[0])!, dy: Int(split2[1])!)
        }
    }

}
