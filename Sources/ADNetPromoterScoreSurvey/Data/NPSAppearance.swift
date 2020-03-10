//
//  NPSAppearance.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 09/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

@objcMembers public class NPSAppearance : NSObject {

    private static let _defaultAppearance = NPSAppearance()
    
    public var scoreQuestionViewAppearance    : NPSScoreQuestionViewAppearance
    public var feedbackQuestionViewAppearance : NPSFeedbackQuestionViewAppearance
    public var thankYouViewAppearance         : NPSThankYouViewAppearance
    
    override init() {
        
        self.scoreQuestionViewAppearance    = NPSScoreQuestionViewAppearance()
        self.feedbackQuestionViewAppearance = NPSFeedbackQuestionViewAppearance()
        self.thankYouViewAppearance         = NPSThankYouViewAppearance()
        super.init()
    }
    
    open class var `default`: NPSAppearance {
        
        get{
        
            return _defaultAppearance
        }
    }
    
    public func setBaseColor(_ color: UIColor) {
        let scoreLook = scoreQuestionViewAppearance
        scoreLook.sliderThumbColor = adjustBrightness(for: color, by: -10)
        scoreLook.sliderMinimumTrackTicksColor = UIColor.black.withAlphaComponent(0.2)
        scoreLook.highRankTitleMarkedColor = color
        scoreLook.lowRankTitleMarkedColor = color
        scoreLook.sliderMinimumTrackBackgroundColor = color
        scoreLook.selectedScoreTextColor = color
        scoreLook.sendButtonBackgroundColor = color
        
        let feedbackLook = feedbackQuestionViewAppearance
        feedbackLook.sendButtonBackgroundColor = color
        feedbackLook.editScoreButtonTextColor = color
        
        thankYouViewAppearance.bottomBannerColor = color
    }
    
    // Based on https://stackoverflow.com/a/38435309
    private func adjustBrightness(for color: UIColor, by percentage: CGFloat) -> UIColor? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: min(r + percentage / 100, 1.0),
                       green: min(g + percentage / 100, 1.0),
                       blue: min(b + percentage / 100, 1.0),
                       alpha: a)
    }
}
