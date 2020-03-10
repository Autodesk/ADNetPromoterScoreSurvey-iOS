//
//  NPSScoreQuestionViewDelegate.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 04/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

protocol NPSScoreQuestionViewDelegate : class{
    
    func scoreQuestionViewDidChangeScoreValue(_ scoreQuestionView : NPSScoreQuestionView,newValue:Int)
    func scoreQuestionViewDidPressClose(_ scoreQuestionView : NPSScoreQuestionView)
    func scoreQuestionViewDidPressSend(_ scoreQuestionView : NPSScoreQuestionView, selectedScore:Int)
}
