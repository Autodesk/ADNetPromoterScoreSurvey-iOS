//
//  NetPromoterScoreSurveyDelegate.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 01/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import Foundation

@objc public  protocol NetPromoterScoreSurveyDelegate : class{
    
    @objc optional func netPromoterScoreViewDidChange(_ npsSurvey: ADNetPromoterScoreSurvey, toView: NetPromoterScoreViewType)
    @objc optional func netPromoterScoreDidPressSendScore(_ npsSurvey: ADNetPromoterScoreSurvey, selectedScore: Int)
    @objc optional func netPromoterScoreDidChangeScoreValue(_ npsSurvey: ADNetPromoterScoreSurvey, newScoreValue: Int)
    @objc optional func netPromoterScoreDidPressEditScore(_ npsSurvey: ADNetPromoterScoreSurvey)
    @objc optional func netPromoterScoreSurveryCompleted(_ npsSurvey: ADNetPromoterScoreSurvey, surveyResult: NPSResult)
    @objc optional func netPromoterScoreDidPressClose(_ npsSurvey: ADNetPromoterScoreSurvey, fromView: NetPromoterScoreViewType)
}
