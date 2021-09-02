//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Created by Daniel Cohen Gindi on 19/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//  https://github.com/danielgindi/Charts/blob/1788e53f22eb3de79eb4f08574d8ea4b54b5e417/ChartsDemo/Classes/Components/BalloonMarker.swift
//  Edit: Added textColor

import Foundation;

import Charts;

import SwiftyJSON;

open class BalloonMarker: MarkerView {
    open var color: UIColor?
    open var arrowSize = CGSize(width: 0, height: 11)
    open var font: UIFont?
    open var font2: UIFont?
    
    open var textColor: UIColor?
    open var textColor2: UIColor?
    
    open var minimumSize = CGSize()
    
    
    fileprivate var insets = UIEdgeInsets(top: 8.0,left: 8.0,bottom: 20.0,right: 8.0)
    fileprivate var topInsets = UIEdgeInsets(top: 20.0,left: 8.0,bottom: 8.0,right: 8.0)
    
    fileprivate var labelns1: NSString?
    fileprivate var labelns2: NSString?
    fileprivate var labelns3: NSString?
    fileprivate var labelns4: NSString?
    
    fileprivate var _labelSize1: CGSize = CGSize()
    fileprivate var _labelSize2: CGSize = CGSize()
    fileprivate var _labelSize3: CGSize = CGSize()
    fileprivate var _labelSize4: CGSize = CGSize()
    
    fileprivate var imageHR: UIImage?
    fileprivate var imageHRUp: UIImage?
    fileprivate var imageHRDown: UIImage?
    fileprivate let separateLine = "|"
    
    fileprivate var _size: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key: Any]()
    
    fileprivate var corner = CGFloat(0)
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, textAlign: NSTextAlignment) {
        super.init(frame: CGRect.zero);
        self.color = color
        self.font = font
        self.textColor = textColor
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = textAlign
    }
    
    public init(color: UIColor, font1: UIFont,font2: UIFont, textColor: UIColor, textColor2: UIColor, textAlign: NSTextAlignment, imageHr: UIImage?, imageHrUp: UIImage?, imageHrDown: UIImage?) {
        super.init(frame: CGRect.zero);
        self.color = color
        self.font = font1
        self.font2 = font2
        self.textColor = textColor
        self.textColor2 = textColor2
        self.imageHR = imageHr
        self.imageHRUp = imageHrUp
        self.imageHRDown = imageHrDown
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = textAlign
        
        corner = CGFloat(15)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    
    func drawRect(context: CGContext, point: CGPoint) -> CGRect{
        
        let chart = super.chartView
        
        let width = _size.width
        
        
        var rect = CGRect(origin: point, size: _size)
        rect.origin.y = 0
        if point.y - _size.height < 0 {
            rect.origin.y =  -self.arrowSize.height
            if point.x - _size.width / 2.0 < 0 {
                drawTopLeftRect(context: context, rect: rect)
            } else if (chart != nil && point.x + width - _size.width / 2.0 > (chart?.bounds.width)!) {
                rect.origin.x -= _size.width
                drawTopRightRect(context: context, rect: rect)
            } else {
                rect.origin.x -= _size.width / 2.0
                drawTopCenterRect(context: context, rect: rect)
            }
            
            rect.origin.y = self.insets.top
            rect.size.height -= self.topInsets.top + self.topInsets.bottom
            
        } else {
            
            if point.x - _size.width / 2.0 < 0 {
                drawLeftRect(context: context, rect: rect)
            } else if (chart != nil && point.x + width - _size.width / 2.0 > (chart?.bounds.width)!) {
                rect.origin.x -= _size.width
                drawRightRect(context: context, rect: rect)
            } else {
                rect.origin.x -= _size.width / 2.0
                drawCenterRect(context: context, rect: rect)
            }
            
            rect.origin.y = self.insets.top
            rect.size.height -= self.insets.top + self.insets.bottom
            
        }
        return rect
    }
    
    func drawCenterRect(context: CGContext, rect: CGRect) {
        print(rect.size.width)
        context.setFillColor((color?.cgColor)!)
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + corner), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height - arrowSize.height - corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + rect.size.height - arrowSize.height), control:  CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width / 2.0, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - arrowSize.height - corner), control:  CGPoint(x: rect.origin.x, y: rect.origin.y  + rect.size.height - arrowSize.height ))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + corner))
        context.addQuadCurve(to:  CGPoint(x: rect.origin.x + corner, y: rect.origin.y), control:  CGPoint(x: rect.origin.x, y: rect.origin.y))
        context.fillPath()
    }
    
    func drawLeftRect(context: CGContext, rect: CGRect) {
        context.setFillColor((color?.cgColor)!)
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + corner), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height - arrowSize.height - corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + rect.size.height - arrowSize.height), control:  CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - arrowSize.height - corner), control:  CGPoint(x: rect.origin.x, y: rect.origin.y  + rect.size.height - arrowSize.height ))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + corner))
        context.addQuadCurve(to:  CGPoint(x: rect.origin.x + corner, y: rect.origin.y), control:  CGPoint(x: rect.origin.x, y: rect.origin.y))
        context.fillPath()
    }
    
    func drawRightRect(context: CGContext, rect: CGRect) {
        context.setFillColor((color?.cgColor)!)
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + corner), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height - corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + rect.size.height - arrowSize.height), control:  CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + rect.size.height - arrowSize.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - arrowSize.height - corner), control:  CGPoint(x: rect.origin.x, y: rect.origin.y  + rect.size.height - arrowSize.height ))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + corner))
        context.addQuadCurve(to:  CGPoint(x: rect.origin.x + corner, y: rect.origin.y), control:  CGPoint(x: rect.origin.x, y: rect.origin.y))
        context.fillPath()
    }
    
    func drawTopCenterRect(context: CGContext, rect: CGRect) {
        context.setFillColor((color?.cgColor)!)
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + arrowSize.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height + corner), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height + rect.size.height - corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + rect.size.height), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + rect.size.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - corner), control: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + arrowSize.height + corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + arrowSize.height), control: CGPoint(x: rect.origin.x, y: rect.origin.y + arrowSize.height))
        context.fillPath()
    }
    
    func drawTopLeftRect(context: CGContext, rect: CGRect) {
        context.setFillColor((color?.cgColor)!)
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + arrowSize.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height + corner), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height + rect.size.height - corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + rect.size.height), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + rect.size.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - corner), control: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + arrowSize.height + corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + arrowSize.height), control: CGPoint(x: rect.origin.x, y: rect.origin.y + arrowSize.height))
        context.fillPath()
    }
    
    func drawTopRightRect(context: CGContext, rect: CGRect) {
        context.setFillColor((color?.cgColor)!)
        context.beginPath()
        context.move(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + arrowSize.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height + corner), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + arrowSize.height + rect.size.height - corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + rect.size.width - corner, y: rect.origin.y + rect.size.height), control: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + rect.size.height))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - corner), control: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + arrowSize.height + corner))
        context.addQuadCurve(to: CGPoint(x: rect.origin.x + corner, y: rect.origin.y + arrowSize.height), control: CGPoint(x: rect.origin.x, y: rect.origin.y + arrowSize.height))
        context.fillPath()
    }
    
    open override func draw(context: CGContext, point: CGPoint) {
        
        if (labelns1 == nil || labelns1?.length == 0) {
            return
        }
        
        if (imageHR != nil &&
                imageHRUp != nil &&
                imageHRDown != nil &&
                labelns1 != nil &&
                labelns2 != nil &&
                labelns3 != nil &&
                labelns4 != nil) {
            let separateWidth = separateLine.size(withAttributes: _drawAttributes)
            let separateColor = UIColor(red: 210.0 / 255.0, green: 212.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
            
            context.saveGState()
            
            let rect = drawRect(context: context, point: point)
            UIGraphicsPushContext(context)
            
            //text 1
            _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor
            let rectText1 = CGRect(
                x: rect.origin.x + self.insets.left,
                y: rect.origin.y,
                width: _labelSize1.width,
                height: rect.height)
            labelns1?.draw(in: rectText1, withAttributes: _drawAttributes)
            
            let imageHrRect = CGRect(
                x: rectText1.origin.x + rectText1.width + 2.0,
                y: rect.origin.y,
                width: _labelSize1.height,
                height: rect.height)
            imageHR?.draw(in: imageHrRect)
            
            _drawAttributes[NSAttributedString.Key.foregroundColor] = separateColor
            let rectSeparate1 = CGRect(
                x: imageHrRect.origin.x + imageHrRect.width + 2.0,
                y: rect.origin.y,
                width: separateWidth.width,
                height: rect.height)
            separateLine.draw(in: rectSeparate1, withAttributes: _drawAttributes)
            
            //text2
            _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor
            let rectText2 = CGRect(
                x: rectSeparate1.origin.x + rectSeparate1.width + 4.0,
                y: rect.origin.y,
                width: _labelSize2.width,
                height: rect.height)
            labelns2?.draw(in: rectText2, withAttributes: _drawAttributes)
            
            let imageHrUpRect = CGRect(
                x: rectText2.origin.x + rectText2.width + 2.0,
                y: rect.origin.y,
                width: _labelSize1.height,
                height: rect.height)
            imageHRUp?.draw(in: imageHrUpRect)
            
            _drawAttributes[NSAttributedString.Key.foregroundColor] = separateColor
            let rectSeparate2 = CGRect(
                x: imageHrUpRect.origin.x + imageHrUpRect.width + 2.0,
                y: rect.origin.y,
                width: separateWidth.width,
                height: rect.height)
            separateLine.draw(in: rectSeparate2, withAttributes: _drawAttributes)
            
            //text3
            _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor
            let rectText3 = CGRect(
                x: rectSeparate2.origin.x + rectSeparate2.width + 4.0,
                y: rect.origin.y,
                width: _labelSize3.width,
                height: rect.height)
            labelns3?.draw(in: rectText3, withAttributes: _drawAttributes)
            
            let imageHrDownRect = CGRect(
                x: rectText3.origin.x + rectText3.width + 2.0,
                y: rect.origin.y,
                width: _labelSize1.height,
                height: rect.height)
            imageHRDown?.draw(in: imageHrDownRect)
            
            //text4
            _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor2
            let rectText4 = CGRect(
                x: imageHrDownRect.origin.x + imageHrDownRect.width + 2.0,
                y: rect.origin.y,
                width: _labelSize4.width,
                height: rect.height)
            labelns4?.draw(in: rectText4, withAttributes: _drawAttributes)
            
            
            
            UIGraphicsPopContext()
            
            context.restoreGState()
            return
        }
        
        context.saveGState()
        
        let rect = drawRect(context: context, point: point)
        UIGraphicsPushContext(context)
        let rectText1 = CGRect(
            x: rect.origin.x + self.insets.left,
            y: rect.origin.y,
            width: _labelSize1.width,
            height: rect.height)
        labelns1?.draw(in: rectText1, withAttributes: _drawAttributes)
        
        _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor2
        let rectText2 = CGRect(
            x: rectText1.origin.x + rectText1.width + 4.0,
            y: rect.origin.y,
            width: _labelSize2.width,
            height: rect.height)
        
        labelns2?.draw(in: rectText2, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        
        var label1 : String = "";
        var label2 : String = "";
        var label3 : String = "";
        var label4 : String = "";
        var separateWidth = CGFloat(0.0)
        var imageWidth = CGFloat(0.0)
        var additionalWidth = CGFloat(0.0)
        
        if let candleEntry = entry as? CandleChartDataEntry {
            label1 = candleEntry.close.description
        } else {
            label1 = entry.y.description
        }
        
        if let object = entry.data as? JSON {
            if object["marker"].exists() {
                let parts = object["marker"].stringValue.components(separatedBy: "@#@");
                
                switch parts.count {
                case 1:
                    label1 = parts[0];
                case 2:
                    label1 = parts[0];
                    label2 = parts[1];
                case 3:
                    label1 = parts[0];
                    label2 = parts[1];
                    label3 = parts[2];
                    separateWidth = separateLine.size(withAttributes: _drawAttributes).width * 2
                    additionalWidth = CGFloat(16.0)
                    imageWidth += _labelSize1.height * 2
                case 4:
                    label1 = parts[0];
                    label2 = parts[1];
                    label3 = parts[2];
                    label4 = parts[3];
                    label4 = parts[3];
                    separateWidth = separateLine.size(withAttributes: _drawAttributes).width * 3
                    additionalWidth = CGFloat(20.0)
                    imageWidth += _labelSize1.height * 3
                default: break
                }
                
                if highlight.stackIndex != -1 && object["marker"].array != nil {
                    label1 = object["marker"].arrayValue[highlight.stackIndex].stringValue
                }
            }
        }
        if(!label1.isEmpty){
            labelns1 = label1 as NSString
        }else{
            labelns1 = nil
        }
        
        if(!label2.isEmpty){
            labelns2 = label2 as NSString
        }else{
            labelns2 = nil
        }
        
        if(!label3.isEmpty){
            labelns3 = label3 as NSString
        }else{
            labelns3 = nil
        }
        
        if(!label4.isEmpty){
            labelns4 = label4 as NSString
        }else{
            labelns4 = nil
        }
        
        _drawAttributes.removeAll()
        _drawAttributes[NSAttributedString.Key.font] = self.font
        _drawAttributes[NSAttributedString.Key.paragraphStyle] = _paragraphStyle
        _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor
        
        _labelSize1 = labelns1?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize2 = labelns2?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize3 = labelns3?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize4 = labelns4?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        _size.width = (_labelSize1.width + _labelSize2.width + _labelSize3.width + _labelSize4.width + separateWidth + imageWidth + additionalWidth) + self.insets.left + self.insets.right
        _size.height = _labelSize1.height + self.insets.top + self.insets.bottom
        _size.width = max(minimumSize.width, _size.width)
        _size.height = max(minimumSize.height, _size.height)
    }
}

