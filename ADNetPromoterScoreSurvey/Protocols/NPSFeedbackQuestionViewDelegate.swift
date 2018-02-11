//
//  NPSFeedbackQuestionViewDelegate.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 04/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

protocol NPSFeedbackQuestionViewDelegate : class{
    
    func moreDetailsViewDidPressClose(_ moreDetailsView: NPSFeedbackQuestionView)
    func moreDetailsViewDidPressSend(_ moreDetailsView: NPSFeedbackQuestionView, text: String)
    func moreDetailsViewDidPressEditScore(_ moreDetailsView: NPSFeedbackQuestionView)
}
