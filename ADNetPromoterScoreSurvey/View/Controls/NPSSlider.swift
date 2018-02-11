//
//  NPSSlider.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 15/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

protocol  NPSSliderDelegate: class{
    
    func sliderValueDidChange(_ slider:NPSSlider,value:Int?)
    func sliderValueWillChange(_ slider:NPSSlider,value:Int?)
}

@IBDesignable class NPSSlider: UIControl {
    
    @IBInspectable public var thumbTintColor                : UIColor = UIColor(red:   0.0/255.0,
                                                                                green: 104.0/255.0,
                                                                                blue:  153.0/255.0,
                                                                                alpha: 1)
    
    @IBInspectable public var minimumTrackBackgroundColor   : UIColor = UIColor(red:   0.0/255.0,
                                                                                green: 150.0/255.0,
                                                                                blue:  220.0/255.0,
                                                                                alpha: 1)
    
    @IBInspectable public var minimumTrackTicksColor        : UIColor = UIColor(red:   0.0/255.0,
                                                                                green: 104.0/255.0,
                                                                                blue:  153.0/255.0,
                                                                                alpha: 1)
    
    @IBInspectable public var maximumTrackTicksColor        : UIColor = UIColor(red:   130.0/255.0,
                                                                                green: 130.0/255.0,
                                                                                blue:  130.0/255.0,
                                                                                alpha: 1)
    public weak var delegate : NPSSliderDelegate?
    
    // Current value
    public var value : Int? = nil{
        
        didSet{
            
            self.setNeedsDisplay()
            self.delegate?.sliderValueDidChange(self, value: self.value)
        }
    }
    
    private var lastWillChangeToValue : Int?
    
    private let maximumValue            = 10
    private let tickDiameter            = 9.0
    private var selectionFillColorLayer = CALayer()
    private var maximumTrackTicksLayer  = CALayer() // The values dots
    private var minimumTrackTicksLayer  = CALayer() // The selected values dots
    private var thumbLayer              = CALayer() // The selected value circle
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.initSlider()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.initSlider()
    }
    
    override func draw(_ rect: CGRect) {
        
        let thumbLocationForCurrentValue = self.thumbRect(value: self.value)
        self.updateSliderUI(thumbLocation: thumbLocationForCurrentValue)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection);
        self.setNeedsDisplay()
        self.refreshUI()
    }
    
    private func initSlider(){
        
        self.clipsToBounds      = true
        self.layer.cornerRadius = self.frame.height/2
        
        self.layer.addSublayer(self.selectionFillColorLayer)
        self.layer.addSublayer(self.maximumTrackTicksLayer)
        self.layer.addSublayer(self.minimumTrackTicksLayer)
        self.layer.addSublayer(self.thumbLayer)
    }
    
    private func refreshUI(){
        
        self.updateSliderUI(thumbLocation: self.thumbRect(value: self.value))
    }
    
    private func updateSliderUI(thumbLocation: CGRect?){
        
        let estimatedSliderValue = self.sliderValue(forRect: thumbLocation)
        
        // Update frames size
        self.maximumTrackTicksLayer.frame            = self.bounds
        self.minimumTrackTicksLayer.frame            = self.bounds
        
        // Update colors
        self.maximumTrackTicksLayer.backgroundColor  = self.maximumTrackTicksColor.cgColor
        self.minimumTrackTicksLayer.backgroundColor  = self.minimumTrackTicksColor.cgColor
        
        let thumbDiameter   = Double(self.frame.height)
        let dotsSpacing     = Double(self.frame.width)/Double(self.maximumValue+1)
        
        let path                = UIBezierPath()
        let selectedValusPath   = UIBezierPath()
        
        for currentDot in 0...self.maximumValue {
            
            let currentDotCenterX = (Double(currentDot) * dotsSpacing) + (dotsSpacing/2)
            let currentDotCenterY = Double(thumbDiameter / 2)
            
            let rectangle = CGRect(x: currentDotCenterX - (self.tickDiameter/2),
                                   y: currentDotCenterY - (self.tickDiameter/2),
                                   width: self.tickDiameter,
                                   height: self.tickDiameter)
            
            if (estimatedSliderValue != nil && currentDot <= estimatedSliderValue!){
                
                selectedValusPath.append(UIBezierPath(roundedRect: rectangle,
                                                      cornerRadius: rectangle.height/2))
            }
            else{
                
                path.append(UIBezierPath(roundedRect: rectangle,
                                         cornerRadius: rectangle.height/2))
            }
        }
        
        let maximumTrackTicksMaskLayer = CAShapeLayer()
        maximumTrackTicksMaskLayer.frame = self.bounds
        maximumTrackTicksMaskLayer.path = path.cgPath
        self.maximumTrackTicksLayer.mask = maximumTrackTicksMaskLayer
        
        let maskLayerMinimumTicks = CAShapeLayer()
        maskLayerMinimumTicks.frame = self.bounds
        maskLayerMinimumTicks.path = selectedValusPath.cgPath
        self.minimumTrackTicksLayer.mask = maskLayerMinimumTicks
        
        // Draw Thumb - Only value is not nil
        guard estimatedSliderValue != nil else { return }
        if let thumbRectangle = thumbRect(value: estimatedSliderValue){
            
            thumbLayer.frame = thumbRectangle
            thumbLayer.backgroundColor = self.thumbTintColor.cgColor
            thumbLayer.borderColor = UIColor.clear.cgColor
            thumbLayer.borderWidth = 0.0
            thumbLayer.cornerRadius = thumbLayer.frame.width/2
            thumbLayer.allowsEdgeAntialiasing = true
            
            let fillRect = CGRect(x:0.0,
                                  y:0.0 ,
                                  width: Double(thumbRectangle.minX) + (thumbDiameter/2),
                                  height: Double(self.frame.height))
            
            self.selectionFillColorLayer.frame = fillRect
            self.selectionFillColorLayer.backgroundColor = self.minimumTrackBackgroundColor.cgColor
        }
    }
    
    private func sliderValue(forRect rect: CGRect?) -> Int?{
        
        guard rect != nil else { return nil }
        
        let point = CGPoint(x: rect!.midX, y: rect!.midY)
        return self.sliderValue(forPoint: point)
    }
    
    private func sliderValue(forPoint: CGPoint) -> Int{
        
        let dotsSpacing   = Double(self.frame.width)/Double(self.maximumValue+1)
        let selectecValue = Double(forPoint.x)/dotsSpacing
        return Int(floor(selectecValue))
    }
    
    private func thumbRect(value: Int?) -> CGRect?{
        
        guard value != nil else { return nil }
        
        let dotsSpacing     = Double(self.frame.width)/Double(maximumValue+1)
        let thumbDiameter   = Double(self.frame.height)
        let thumbWidth      = thumbDiameter
        let thumbHeight     = thumbDiameter
        
        let currentDotCenterX = (Double(value!) * dotsSpacing) + (dotsSpacing/2)
        let thumbY = 0.0
        
        let rectangle = CGRect(x:currentDotCenterX-(thumbDiameter/2),
                               y: thumbY,
                               width: thumbWidth,
                               height: thumbHeight)
        return rectangle
    }
    
    private func thumbRect(forPoint point: CGPoint) -> CGRect{
        
        let value = self.sliderValue(forPoint: point)
        return self.thumbRect(value: value)!
    }
    
    
    // MARK: --- Gesture Handling ---
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            CATransaction.setAnimationDuration(0)
            let location = touch.location(in: touch.view)
            let thumbRectangle = self.thumbRect(forPoint: location)
            let willChangeToValue = self.sliderValue(forPoint: location)
            
            if (willChangeToValue != self.lastWillChangeToValue){
                
                self.delegate?.sliderValueWillChange(self, value: willChangeToValue)
                self.lastWillChangeToValue = willChangeToValue
            }
            
            self.updateSliderUI(thumbLocation: thumbRectangle)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            // Convert touch location to value
            let location = touch.location(in: touch.view)
            var newValue = self.sliderValue(forPoint: location)
            
            // Make sure user dont pass the slider limit values
            newValue = (newValue < 0) ? 0 : newValue
            newValue = (newValue > maximumValue) ? maximumValue : newValue
            
            // Update current value
            if (self.value == nil ) { CATransaction.setAnimationDuration(0) } // Disable animation for first value set
            self.value = newValue
        }
    }
}
