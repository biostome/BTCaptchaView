//
//  BTCaptchaView.swift
//  BTCaptchaView
//
//  Created by nathan on 2019/5/10.
//  Copyright © 2019 nathan. All rights reserved.
//
import UIKit


public class BTCaptchaView: UIView {
    
    /// interference line total count
    public var interferenceLineCount:Int = 6
    /// interference line width
    public var interferenceLineWidth:CGFloat = 2.0
    /// character font sizse
    public var font:UIFont = UIFont.systemFont(ofSize:(CGFloat(arc4random() % 5) + 18))
    /// click view self
    public var onTouch:(()->Void)?
    /// set code in view 
    public var code:String?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    public init(frame: CGRect,code:String) {
        super.init(frame: frame)
        self.code = code
        initBackgroundColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBackgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBackgroundColor()
    }
    
    private func initBackgroundColor() {
        self.backgroundColor = arc4randomBackgroundColor(alpha: 1.0)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        onTouch?()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCaptcha(rect)
    }
}

fileprivate extension BTCaptchaView {
    func arc4randomBackgroundColor(alpha:CGFloat) -> UIColor {
        let randomBackColor = UIColor(red: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), green: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), blue: CGFloat(CGFloat(arc4random())/CGFloat(RAND_MAX)), alpha: alpha)
        return randomBackColor
    }
}

fileprivate extension BTCaptchaView {
    
    func drawCaptcha(_ rect: CGRect){
        self.backgroundColor = arc4randomBackgroundColor(alpha: 1.0)
        
        if let code = self.code {
            //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
            let attributes = [NSAttributedString.Key.font : font]
            let size = NSString(string: "S").size(withAttributes: (attributes))
            let width = rect.size.width / CGFloat(code.count) - size.width
            let height = rect.size.height - size.height
            let stringCount = code.count
            for i in 0 ..< stringCount {
                let pointX = CGFloat(arc4random()).truncatingRemainder(dividingBy: width) + rect.size.width / CGFloat(NSString(string: code).length)*CGFloat(i)
                let pointY = CGFloat(arc4random()).truncatingRemainder(dividingBy: height)
                let point = CGPoint(x:pointX, y:pointY)
                let c = NSString(string: code).character(at: i)
                let codeText:NSString = NSString(format: "%C",c)
                codeText.draw(at: point, withAttributes:  attributes)
            }
        }
        
        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        let context :CGContext = UIGraphicsGetCurrentContext()!
        context.setLineWidth(interferenceLineWidth)
        for _ in 0 ..< interferenceLineCount {
            //绘制干扰的彩色直线
            context.setStrokeColor(arc4randomBackgroundColor(alpha: 0.5).cgColor)
            //设置线的起点
            let startPointX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            let startPointY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.move(to: CGPoint(x:startPointX, y:startPointY))
            //设置线终点
            let endPointX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            let endPointY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            let endPoint = CGPoint(x:endPointX, y:endPointY)
            context.addLine(to: endPoint)
            //画线
            context.strokePath()
        }
    }
}
