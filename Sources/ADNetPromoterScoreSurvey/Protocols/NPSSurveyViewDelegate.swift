//
//  NPSSurveyViewDelegate.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 04/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

protocol NPSSurveyViewDelegate : class{
    
    func surveyViewDidPressClose(_ surveyView: NPSSurveyViewProtocol, fromView: NetPromoterScoreViewType)
    func surveyViewScoreSliderValueDidChange(_ surveyView: NPSSurveyViewProtocol, newValue: Int)
    func surveyViewDidSendScore(_ surveyView: NPSSurveyViewProtocol, score: Int)
    func surveyViewDidPressEditScore(_ surveyView: NPSSurveyViewProtocol)
    func surveyViewDidPressSendFeedback(_ surveyView: NPSSurveyViewProtocol, feedbackText: String)
    func surveyViewDidChange(_ surveyView: NPSSurveyViewProtocol, toView: NetPromoterScoreViewType)
    func surveyViewAppearance(_ surveyView: NPSSurveyViewProtocol, forView: NetPromoterScoreViewType) -> NPSAppearance
}
