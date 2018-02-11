//
//  NetPromoterScoreSurveyDelegateMock.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 23/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit
@testable import ADNetPromoterScoreSurvey

class NetPromoterScoreSurveyDelegateMock: NetPromoterScoreSurveyDelegate {

    var netPromoterScoreViewDidChangeExecutionCounter           = 0
    var netPromoterScoreDidPressSendScoreExecutionCounter       = 0
    var netPromoterScoreDidChangeScoreValueExecutionCounter     = 0
    var netPromoterScoreDidPressEditScoreExecutionCounter       = 0
    var netPromoterScoreSurveryCompletedExecutionCounter        = 0
    var netPromoterScoreDidPressCloseExecutionCounter           = 0
    
    var netPromoterScoreViewDidChangeCustomAction           : ((ADNetPromoterScoreSurvey,NetPromoterScoreViewType) -> ())?
    var netPromoterScoreDidPressSendScoreCustomAction       : ((ADNetPromoterScoreSurvey,Int) -> ())?
    var netPromoterScoreDidChangeScoreValueCustomAction     : ((ADNetPromoterScoreSurvey,Int) -> ())?
    var netPromoterScoreDidPressEditScoreCustomAction       : ((ADNetPromoterScoreSurvey) -> ())?
    var netPromoterScoreSurveryCompletedCustomAction        : ((ADNetPromoterScoreSurvey,NPSResult) -> ())?
    var netPromoterScoreDidPressCloseCustomAction           : ((ADNetPromoterScoreSurvey,NetPromoterScoreViewType) -> ())?
    
    func netPromoterScoreViewDidChange(_ npsSurvey: ADNetPromoterScoreSurvey, toView: NetPromoterScoreViewType){
        
        self.netPromoterScoreViewDidChangeExecutionCounter += 1
        self.netPromoterScoreViewDidChangeCustomAction?(npsSurvey,toView)
    }
    
    func netPromoterScoreDidPressSendScore(_ npsSurvey: ADNetPromoterScoreSurvey, selectedScore: Int){
        
        self.netPromoterScoreDidPressSendScoreExecutionCounter += 1
        self.netPromoterScoreDidPressSendScoreCustomAction?(npsSurvey,selectedScore)
    }
    
    func netPromoterScoreDidChangeScoreValue(_ npsSurvey: ADNetPromoterScoreSurvey, newScoreValue: Int){
        
        self.netPromoterScoreDidChangeScoreValueExecutionCounter += 1
        self.netPromoterScoreDidChangeScoreValueCustomAction?(npsSurvey,newScoreValue)
    }
    
    func netPromoterScoreDidPressEditScore(_ npsSurvey: ADNetPromoterScoreSurvey){
        
        self.netPromoterScoreDidPressEditScoreExecutionCounter += 1
        self.netPromoterScoreDidPressEditScoreCustomAction?(npsSurvey)
    }
    
    func netPromoterScoreSurveryCompleted(_ npsSurvey: ADNetPromoterScoreSurvey, surveyResult: NPSResult){
        
        self.netPromoterScoreSurveryCompletedExecutionCounter += 1
        self.netPromoterScoreSurveryCompletedCustomAction?(npsSurvey,surveyResult)
    }
    
    func netPromoterScoreDidPressClose(_ npsSurvey: ADNetPromoterScoreSurvey, fromView: NetPromoterScoreViewType){
        
        self.netPromoterScoreDidPressCloseExecutionCounter += 1
        self.netPromoterScoreDidPressCloseCustomAction?(npsSurvey,fromView)
    }
}
