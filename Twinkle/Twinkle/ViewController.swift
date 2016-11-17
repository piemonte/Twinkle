//  ViewController.swift
//
//  Created by patrick piemonte on 2/20/15.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

class ViewController: UIViewController {

    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        self.view.backgroundColor = UIColor(red: 81/255, green: 0, blue: 97/255, alpha: 1)
        
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 240, height: 50))
        button.center = self.view.center
        button.setTitle("Tap to Twinkle", for: UIControlState())
        button.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 32)
        button.addTarget(self, action: #selector(ViewController.handleButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    // MARK: UIButton handler
    
    func handleButton(_ button: UIButton!) {
        button.twinkle(starImage: UIImage(named: "TwinkleImage"))
    }
}

