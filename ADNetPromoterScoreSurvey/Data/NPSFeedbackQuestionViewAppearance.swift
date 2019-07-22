//
//  NPSFeedbackQuestionViewAppearance.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 09/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

@objcMembers public class NPSFeedbackQuestionViewAppearance : NSObject{
    
    public var titleForPromoter             = "Thanks for your feedback!"
    public var titleForPassive              = "Thanks for your feedback!"
    public var titleForDetractor            = "We appreciate your feedback"
    public var placeholderForPromoter       = "Let us know if there’s anything you want to share with us"
    public var placeholderForPassive        = "Let us know how we can make the app better"
    public var placeholderForDetractor      = "Let us know how we can make the app better"
    public var sendButtonTitle              = "SEND"
    public var editScoreButtonTitle         = "EDIT SCORE"
    
    public var titleFont                : UIFont?
    public var placeholderFont          : UIFont?
    public var textFieldFont            : UIFont?
    public var sendButtonTitleFont      : UIFont?
    public var editScoreButtonTitleFont : UIFont?
 
    public var backgroundColor              : UIColor?
    public var titleFontColor               : UIColor?
    public var placehoderFontColor          : UIColor?
    public var textFieldFontColor           : UIColor?
    public var sendButtonTitleColor         : UIColor?
    public var sendButtonBackgroundColor    : UIColor?
    public var editScoreButtonTextColor     : UIColor?
    public var feedbackTextBlackgroundColor : UIColor?
}
