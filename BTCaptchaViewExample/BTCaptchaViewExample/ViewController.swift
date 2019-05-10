//
//  ViewController.swift
//  TestCView
//
//  Created by nathan on 2019/5/10.
//  Copyright © 2019 nathan. All rights reserved.
//

import UIKit
import BTCaptchaView

class ViewController: UIViewController {
    
    @IBOutlet weak var codeView: BTCaptchaView! {
        didSet{
            codeView.code = "123"
        }
    }
    
    lazy var codeView1: BTCaptchaView = {
        let view = BTCaptchaView.init()
        view.font = UIFont.systemFont(ofSize: 30)
        view.interferenceLineCount = 20
        view.interferenceLineWidth = 10
        view.code = "1234"
        view.frame = CGRect.init(x: 0, y: 50, width: 100, height: 50)
        view.onTouch = {
            print("touch")
        }
        return view
    }()
    
    lazy var codeView2: BTCaptchaView = {
        let view = BTCaptchaView.init(frame: CGRect.init(x: 0, y: 150, width: 100, height: 50), code: "12345")
        view.font = UIFont.systemFont(ofSize: 30)
        view.onTouch = {
            print("touch")
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(codeView1)
        view.addSubview(codeView2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        codeView.code = "321"
        codeView1.code = "4321"
        codeView2.code = "54321"
    }
}



