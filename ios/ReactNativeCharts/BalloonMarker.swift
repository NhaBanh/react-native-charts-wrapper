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

    fileprivate var _labelSize1: CGSize = CGSize()
    fileprivate var _labelSize2: CGSize = CGSize()

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
    
    public init(color: UIColor, font1: UIFont,font2: UIFont, textColor: UIColor, textColor2: UIColor, textAlign: NSTextAlignment) {
        super.init(frame: CGRect.zero);
        self.color = color
        self.font = font1
        self.font2 = font2
        self.textColor = textColor
        self.textColor2 = textColor2
        
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
            x: rectText1.origin.x + _labelSize1.width,
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

        if let candleEntry = entry as? CandleChartDataEntry {
            label1 = candleEntry.close.description
        } else {
            label1 = entry.y.description
        }

        if let object = entry.data as? JSON {
            if object["marker"].exists() {
                let parts = object["marker"].stringValue.components(separatedBy: "@#@");
            
                if(parts.count >= 1){
                    label1 = parts[0];
                }
                if(parts.count >= 2){
                    label2 = " " + parts[1];
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

        _drawAttributes.removeAll()
        _drawAttributes[NSAttributedString.Key.font] = self.font
        _drawAttributes[NSAttributedString.Key.paragraphStyle] = _paragraphStyle
        _drawAttributes[NSAttributedString.Key.foregroundColor] = self.textColor

        _labelSize1 = labelns1?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        _labelSize2 = labelns2?.size(withAttributes: _drawAttributes) ?? CGSize.zero

        _size.width = (_labelSize1.width+_labelSize2.width) + self.insets.left + self.insets.right
        _size.height = _labelSize1.height + self.insets.top + self.insets.bottom
        _size.width = max(minimumSize.width, _size.width)
        _size.height = max(minimumSize.height, _size.height)

    }
}

