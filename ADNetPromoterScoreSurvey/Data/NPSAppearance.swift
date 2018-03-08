//
//  NPSAppearance.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 09/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

@objcMembers
public class NPSAppearance : NSObject {

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
}
