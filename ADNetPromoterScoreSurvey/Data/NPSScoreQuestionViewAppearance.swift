//
//  NPSScoreQuestionViewAppearance.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 09/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

public class NPSScoreQuestionViewAppearance: NSObject{
    
    public var questionText     = LOC_QUESTION_TEXT
    public var lowRankTitle     = LOC_RANK_LOW_TITLE
    public var highRankTitle    = LOC_RANK_HIGH_TITLE
    public var sendButtonTitle  = LOC_BTN_SEND.localizedUppercase
    
    // Fonts
    public var questionTextFont             : UIFont?
    public var sendButtonTitleFont          : UIFont?
    public var scoresTextFont               : UIFont?
    public var selectedScoreTextFont        : UIFont?
    public var lowRankTitleFont             : UIFont?
    public var highRankTitleFont            : UIFont?
    public var lowRankTitleMarkedFont       : UIFont?
    public var highRankTitleMarkedFont      : UIFont?
    
    // Colors
    public var questionTextColor            : UIColor?
    public var sendButtonBackgroundColor    : UIColor?
    public var sendButtonTextColor          : UIColor?
    public var scoresTextColor              : UIColor?
    public var selectedScoreTextColor       : UIColor?
    public var lowRankTitleColor            : UIColor?
    public var highRankTitleColor           : UIColor?
    public var lowRankTitleMarkedColor      : UIColor?
    public var highRankTitleMarkedColor     : UIColor?
    public var backgroundColor              : UIColor?
    
    // Slider Colors
    public var sliderThumbColor                     : UIColor?
    public var sliderMaximumTrackTicksColor         : UIColor?
    public var sliderMinimumTrackTicksColor         : UIColor?
    public var sliderMinimumTrackBackgroundColor    : UIColor?
    public var sliderBackgroundColor                : UIColor?
}
