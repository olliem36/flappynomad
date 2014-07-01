//
//  OJMLoadingView.swift
//  FlappyBird
//
//  Created by Oliver Mahoney on 01/07/2014.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import UIKit

class OJMLoadingView: UIView {
    
    var lblMessage : UILabel!
    var loadingIndicator : UIProgressView!
    var message : String!

    init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, message : String) {
        super.init(frame: frame)
        self.message = message
        println("message: \(message) - self: \(self.message)")
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.opacity = 0.7
        self.backgroundColor = UIColor.darkGrayColor()
        
        var frameLabel:CGRect = frame
        var frameProgress:CGRect = frame
        
        var halfHeight = (frame.size.height / 2);
        
        frameLabel.size.height = halfHeight
        frameProgress.origin.y = halfHeight + (halfHeight / 2)
        frameProgress.size.height = (halfHeight / 2)
        frameProgress.size.width = halfHeight
        
        lblMessage = UILabel(frame: frame)
        lblMessage.textAlignment = NSTextAlignment.Center
        lblMessage.numberOfLines = 0;
        lblMessage.text = message
        lblMessage.textColor = UIColor.whiteColor()
        
        println("message: \(message) - self: \(self.message)")
        
        lblMessage.font = UIFont.systemFontOfSize(16)
        
        loadingIndicator = UIProgressView(frame: frameProgress)
        loadingIndicator.progressViewStyle = UIProgressViewStyle.Default
        loadingIndicator.progress = 0.5
        
        self.addSubview(lblMessage)
        //self.addSubview(loadingIndicator)
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //override func drawRect(rect: CGRect)
   // {
        // Drawing code
        //self.backgroundColor = UIColor.darkGrayColor()
        
        
   // }
    

}
