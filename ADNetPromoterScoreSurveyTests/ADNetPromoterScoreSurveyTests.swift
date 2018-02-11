//
//  ADNetPromoterScoreSurveyTests.swift
//  ADNetPromoterScoreSurveyTests
//
//  Created by Tomer Shalom on 28/09/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import XCTest
@testable import ADNetPromoterScoreSurvey

class ADNetPromoterScoreSurveyTests: XCTestCase {
    
    var netPromoterScoreSurvey  : ADNetPromoterScoreSurvey?
    var surveyViewMock          : NPSSurveyViewMock?
    var surveyDelegateMock      : NetPromoterScoreSurveyDelegateMock?
    
    var viewController          : UIViewController = UIViewController()
    
    override func setUp() {
        
        super.setUp()
        
        self.surveyViewMock         = NPSSurveyViewMock()
        self.surveyDelegateMock     = NetPromoterScoreSurveyDelegateMock()
        self.netPromoterScoreSurvey = ADNetPromoterScoreSurvey(customSurveyView: self.surveyViewMock!)
        
        self.netPromoterScoreSurvey?.delegate = self.surveyDelegateMock
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_showSurvey_should_call_showSurvey() {
        
        // Act
        self.netPromoterScoreSurvey?.showSurvey(onViewController: self.viewController)
        
        // Verify
        XCTAssert(self.surveyViewMock?.showSurveyExecutionCounter == 1)
    }
    
    func test_closeSurvey_should_call_closeSurvey(){

        // Act
        self.netPromoterScoreSurvey?.closeSurvey()
        
        // Verify
        XCTAssert(self.surveyViewMock?.closeSurveyExecutionCounter == 1)
    }
    
    func test_user_press_close_from_score_view(){
        
        // Setup
        var fromViewIsScoreView = false
        
        self.surveyDelegateMock?.netPromoterScoreDidPressCloseCustomAction = { (surveyView,fromView) in
            
            fromViewIsScoreView = (fromView == .scoreQuestionView)
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewDidPressClose(self.surveyViewMock!, fromView: .scoreQuestionView)

        
        // Verify
        XCTAssert(self.surveyViewMock?.closeSurveyExecutionCounter == 1)
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidPressCloseExecutionCounter == 1)
        XCTAssert(fromViewIsScoreView)
    }
    
    func test_user_press_close_from_feedback_view(){
        
        // Setup
        var fromViewIsFeedbackView = false
        
        self.surveyDelegateMock?.netPromoterScoreDidPressCloseCustomAction = { (surveyView,fromView) in
            
            fromViewIsFeedbackView = (fromView == .feedbackQuestionView)
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewDidPressClose(self.surveyViewMock!, fromView: .feedbackQuestionView)
        
        
        // Verify
        XCTAssert(self.surveyViewMock?.closeSurveyExecutionCounter == 1)
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidPressCloseExecutionCounter == 1)
        XCTAssert(fromViewIsFeedbackView)
    }
    
    func test_user_press_close_from_thanks_view(){
        
        // Setup
        var fromViewIsThankYouView = false
        
        self.surveyDelegateMock?.netPromoterScoreDidPressCloseCustomAction = { (surveyView,fromView) in
            
            fromViewIsThankYouView = (fromView == .thankYouView)
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewDidPressClose(self.surveyViewMock!, fromView: .thankYouView)
        
        
        // Verify
        XCTAssert(self.surveyViewMock?.closeSurveyExecutionCounter == 1)
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidPressCloseExecutionCounter == 1)
        XCTAssert(fromViewIsThankYouView)
    }
    
    func test_user_did_change_score_value_to_0(){
        
        // Setup
        var actualSelectedValue = -999
        
        self.surveyDelegateMock?.netPromoterScoreDidChangeScoreValueCustomAction = { (survey,selectedValue) in
            
            actualSelectedValue = selectedValue
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewScoreSliderValueDidChange(self.surveyViewMock!, newValue: 0)
        
        // Verify
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidChangeScoreValueExecutionCounter == 1)
        XCTAssert(actualSelectedValue == 0)
    }
    
    func test_user_did_change_score_value_to_10(){
        
        // Setup
        var actualSelectedValue = -999
        
        self.surveyDelegateMock?.netPromoterScoreDidChangeScoreValueCustomAction = { (survey,selectedValue) in
            
            actualSelectedValue = selectedValue
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewScoreSliderValueDidChange(self.surveyViewMock!, newValue: 10)
        
        // Verify
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidChangeScoreValueExecutionCounter == 1)
        XCTAssert(actualSelectedValue == 10)
    }
    
    func test_user_did_change_score_value_twice(){
        
        // Setup
        var actualSelectedValue = -999
        
        self.surveyDelegateMock?.netPromoterScoreDidChangeScoreValueCustomAction = { (survey,selectedValue) in
            
            actualSelectedValue = selectedValue
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewScoreSliderValueDidChange(self.surveyViewMock!, newValue: 10)
        self.netPromoterScoreSurvey?.surveyViewScoreSliderValueDidChange(self.surveyViewMock!, newValue: 5)
        
        // Verify
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidChangeScoreValueExecutionCounter == 2)
        XCTAssert(actualSelectedValue == 5)
    }
    
    func test_user_did_send_score_with_value_0(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 0, expectedScore: 0, expectedPromoterType: .detractor)
    }

    func test_user_did_send_score_with_value_1(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 1, expectedScore: 1, expectedPromoterType: .detractor)
    }
    
    func test_user_did_send_score_with_value_2(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 2, expectedScore: 2, expectedPromoterType: .detractor)
    }
    
    func test_user_did_send_score_with_value_3(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 3, expectedScore: 3, expectedPromoterType: .detractor)
    }
    
    func test_user_did_send_score_with_value_4(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 4, expectedScore: 4, expectedPromoterType: .detractor)
    }
    
    func test_user_did_send_score_with_value_5(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 5, expectedScore: 5, expectedPromoterType: .detractor)
    }
    
    func test_user_did_send_score_with_value_6(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 6, expectedScore: 6, expectedPromoterType: .detractor)
    }
    
    func test_user_did_send_score_with_value_7(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 7, expectedScore: 7, expectedPromoterType: .passive)
    }
    
    func test_user_did_send_score_with_value_8(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 8, expectedScore: 8, expectedPromoterType: .passive)
    }
    
    func test_user_did_send_score_with_value_9(){
        
        self.runSurveyViewDidSendScoreTest(withScore: 9, expectedScore: 9, expectedPromoterType: .promoter)
    }
    
    func test_user_did_send_score_with_value_10(){

        self.runSurveyViewDidSendScoreTest(withScore: 10, expectedScore: 10, expectedPromoterType: .promoter)
    }
    
    func test_user_did_press_edit_score(){
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewDidPressEditScore(self.surveyViewMock!)
        
        // Verify
        XCTAssert(self.surveyViewMock?.backToSendScoreViewExecutionCounter == 1)
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidPressEditScoreExecutionCounter == 1)
    }
    
    func test_user_press_send_feedback_detractor(){
        
        let userScore            = 1
        let userFeedback         = "not good"
        let expectedPromoterType =  NetPromoterType.detractor
        
        self.runSurveyViewDidSendScoreTest(withScore: userScore,
                                           expectedScore: userScore,
                                           expectedPromoterType: expectedPromoterType)
        
        self.runSurveyViewDidSendFeedbackTest(withText: userFeedback,
                                              expectedFeedbackText: userFeedback,
                                              expectedScore: userScore,
                                              expectedPromoterType: expectedPromoterType)
    }


    func test_user_press_send_feedback_passive(){
        
        let userScore            = 7
        let userFeedback         = "ok"
        let expectedPromoterType =  NetPromoterType.passive
        
        self.runSurveyViewDidSendScoreTest(withScore: userScore,
                                           expectedScore: userScore,
                                           expectedPromoterType: expectedPromoterType)
        
        self.runSurveyViewDidSendFeedbackTest(withText: userFeedback,
                                              expectedFeedbackText: userFeedback,
                                              expectedScore: userScore,
                                              expectedPromoterType: expectedPromoterType)
    }

    func test_user_press_send_feedback_promoter(){
        
        let userScore            = 10
        let userFeedback         = "great!"
        let expectedPromoterType =  NetPromoterType.promoter
        
        self.runSurveyViewDidSendScoreTest(withScore: userScore,
                                           expectedScore: userScore,
                                           expectedPromoterType: expectedPromoterType)
        
        self.runSurveyViewDidSendFeedbackTest(withText: userFeedback,
                                              expectedFeedbackText: userFeedback,
                                              expectedScore: userScore,
                                              expectedPromoterType: expectedPromoterType)
    }
    
    // MARK: Private helpers
    
    private func runSurveyViewDidSendScoreTest(withScore score: Int!, expectedScore: Int!, expectedPromoterType: NetPromoterType){

        
        var actualScore = -999
        self.surveyDelegateMock?.netPromoterScoreDidPressSendScoreCustomAction = { (survey,score) in
            
            actualScore = score
        }
        
        var actualPromoterType : NetPromoterType?
        self.surveyViewMock?.continueToSendDetailsViewCustomAction = { (promoterType) in
            
            actualPromoterType = promoterType
        }
        
        // Act
        self.netPromoterScoreSurvey?.surveyViewDidSendScore(self.surveyViewMock!,score: score)
        
        // Verify
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreDidPressSendScoreExecutionCounter == 1)
        XCTAssert(self.surveyViewMock?.continueToSendDetailsViewExecutionCounter == 1)
        XCTAssert(actualScore == expectedScore)
        XCTAssert(actualPromoterType == expectedPromoterType)
    }
    
    private func runSurveyViewDidSendFeedbackTest(withText feedbackText:String!,expectedFeedbackText: String!,expectedScore: Int!, expectedPromoterType: NetPromoterType){
        
        var npsResult : NPSResult?
        self.surveyDelegateMock?.netPromoterScoreSurveryCompletedCustomAction = { (survey,result) in
            
            npsResult = result
        }
        
        self.netPromoterScoreSurvey?.surveyViewDidPressSendFeedback(self.surveyViewMock!, feedbackText: feedbackText)
        
        XCTAssert(self.surveyViewMock?.showThankYouViewExecutionCounter == 1)
        XCTAssert(self.surveyDelegateMock?.netPromoterScoreSurveryCompletedExecutionCounter == 1)
        XCTAssert(npsResult?.score == expectedScore)
        XCTAssert(npsResult?.promoterType == expectedPromoterType)
        XCTAssert(npsResult?.feedback  == expectedFeedbackText)
    }
}
