//
//  ViewController.swift
//  MouseMoveReceiver
//
//  Created by cmlab on 2017/08/24.
//  Copyright © 2017年 cmlab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
    private var sockmgr: SocketManager = SocketManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        sockmgr.delegate = self
        label.text = "dx = 0, dy = 0"
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: SocketManagerDelegate {
    func manager(manager: SocketManager, scrollBy move: (Int, Int)) {
        label.text = "dx = \(move.0), dy = \(move.1)"
    }

}
