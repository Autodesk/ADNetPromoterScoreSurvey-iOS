//
//  NPSThankYouView.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 03/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

class NPSThankYouView: NPSBaseView {

    fileprivate lazy var animateInStartYLocation: CGFloat = {
        
        return -(self.contentView.frame.height + self.closeButtonContentViewHeightAddition)
    }()
    
    fileprivate lazy var animateInTopToSafeAreaStartLocation: CGFloat = {
        
        var safeAreaBottomHeight: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            safeAreaBottomHeight = self.safeAreaInsets.bottom
        }
        return -(safeAreaBottomHeight + self.closeButtonContentViewHeightAddition)
    }()
    
    weak var delegate: NPSThankYouViewDelegate?
    
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var contentViewToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTopToSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomColoredBorderHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bottomBannerView: UIView!
    @IBOutlet weak var thankYouImageView: UIImageView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Load custom image if needed
        if let _ = self.appearance.thankYouViewAppearance.thankYouImage{
            self.thankYouImageView.image = self.appearance.thankYouViewAppearance.thankYouImage
        }
        
        self.layoutIfNeeded()
    }
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.delegate?.thankYouViewDidPressClose(self)
    }
    
    override func setupTexts() {
        
        super.setupTexts()
        self.thanksLabel.text = self.appearance.thankYouViewAppearance.thankYouMessageText
    }
    
    override func setupColors() {
        
        super.setupColors()
        
        let appearance = self.appearance.thankYouViewAppearance
        self.contentView.backgroundColor        = appearance.backgroundColor ?? self.contentView.backgroundColor
        self.thanksLabel.textColor              = appearance.thankYouMessageTextColor ?? self.thanksLabel.textColor
        self.bottomBannerView.backgroundColor   = appearance.bottomBannerColor ?? self.bottomBannerView.backgroundColor
    }
    
    override func setupFonts() {
        
        super.setupFonts()
        
        if let _ = self.appearance.thankYouViewAppearance.thankYouMessageFont{
            
            self.thanksLabel.font = self.appearance.thankYouViewAppearance.thankYouMessageFont
        }
    }
    
    override func animateIn(withDuration duration: TimeInterval, completionBlock : (() -> ())?){
        
        self.initAnimateInStartPositions()
        
        self.contentViewToBottomConstraint.constant = 0
        self.contentViewTopToSafeAreaConstraint.constant = 144
        
        UIView.animate(withDuration: duration, animations: {
            
            self.layoutIfNeeded()
        },completion:{ (finished) in
            
            completionBlock?()
        })
    }
    
    override func animateOut(withDuration duration: TimeInterval, completionBlock : (() -> ())?){
        
        self.contentViewToBottomConstraint.constant = animateInStartYLocation
        self.contentViewTopToSafeAreaConstraint.constant = self.animateInTopToSafeAreaStartLocation
        
        UIView.animate(withDuration: duration, animations: {
            
            self.layoutIfNeeded()
        },completion:{ (finished) in
            
            if (finished){
                completionBlock?()
            }
        })
    }
    
    override func handleSwipeDownGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        super.handleSwipeDownGesture(gesture: gesture)
        self.delegate?.thankYouViewDidPressClose(self)
    }
    
    private func initAnimateInStartPositions(){
        
        self.contentViewToBottomConstraint.constant = animateInStartYLocation
        self.contentViewTopToSafeAreaConstraint.constant = self.animateInTopToSafeAreaStartLocation
        
        if #available(iOS 11.0, *) {
            self.bottomColoredBorderHeightConstraint.constant +=  self.safeAreaInsets.bottom
        }
        
        self.layoutIfNeeded()
    }
}
