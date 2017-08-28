//
//  ViewController.swift
//  MouseMoveReceiver
//
//  Created by cmlab on 2017/08/24.
//  Copyright © 2017年 cmlab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
    private var sockmgr: SocketManager? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sockmgr = SocketManager(withViewController: self)
        sockmgr?.startServer()
        label.text = "dx = 0, dy = 0"
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollBy(dx: Int, dy: Int) {
        label.text = "dx = \(dx), dy = \(dy)"
    }
}

