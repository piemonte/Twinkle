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
    
    private var textLabel: UILabel!
    
    // MARK: object lifecycle
    
    convenience init() {
        self.init(nibName: nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.autoresizingMask = ([UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight])
        self.view.backgroundColor = UIColor(red: 81/255, green: 0, blue: 97/255, alpha: 1)
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        tapGestureRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.PlayPause.rawValue)];
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        textLabel = UILabel(frame: CGRectMake(0, 0, 800, 150))
        textLabel.center = self.view.center
        textLabel.text = "Play/Pause to Twinkle"
        textLabel.textColor = UIColor.whiteColor()
        textLabel.font = UIFont(name: "AvenirNext-Regular", size: 72)
        self.view.addSubview(textLabel)
    }
    
    // MARK: UIButton handler
    
    func handleTap(button: UITapGestureRecognizer!) {
        textLabel.twinkle(starImage: UIImage(named: "TwinkleImage"))
    }
}
