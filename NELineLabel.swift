//
//  NELineLabel.swift
//  Marco Cancellieri
//
//  Created by Marco Cancellieri on 08/03/16.
//  Copyright © 2016 Marco Cancellieri. All rights reserved.
//

import UIKit

@IBDesignable
open class NELineLabel: UILabel {

    @IBInspectable
    open var lineHeight: CGFloat = 1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    open var lineSpace: CGFloat = 10 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    open var lineY: CGFloat {
        return self.bounds.midY - self.lineHeight / 2
    }
    
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let size = self.intrinsicContentSize
        
        if rect.width > size.width, let ctx = UIGraphicsGetCurrentContext() {
            ctx.saveGState()
            self.textColor.setFill()
            
            var alignment = textAlignment
            
            if textAlignment == .natural {
                alignment = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight ? .left : .right
            }

            switch alignment {
            case .center:
                let lineWidth = (rect.width - size.width) / 2 - lineSpace
                drawLineLeft(ctx, lineWidth: lineWidth)
                drawLineRight(ctx, lineWidth: lineWidth)
            case .left, .right:
                let lineWidth = rect.width - size.width - lineSpace
                alignment == .left ? drawLineRight(ctx, lineWidth: lineWidth) : drawLineLeft(ctx, lineWidth: lineWidth)
            default:
                debugPrint("\(self.textAlignment) not supported by LineLabel")
            }
            
            ctx.restoreGState()
        }
        
    }
    
    func drawLineLeft(_ ctx: CGContext, lineWidth: CGFloat) {
        let leftRect = lineRect(bounds.minX, lineWidth: lineWidth)
        ctx.fill(leftRect)

    }
    func drawLineRight(_ ctx: CGContext, lineWidth: CGFloat) {
        let leftRect = lineRect(bounds.maxX - lineWidth, lineWidth: lineWidth)
        ctx.fill(leftRect)
    }
    
    func lineRect(_ x: CGFloat, lineWidth: CGFloat) -> CGRect {
        return CGRect(x: x, y: self.lineY, width: lineWidth, height: self.lineHeight)
    }
    
}
