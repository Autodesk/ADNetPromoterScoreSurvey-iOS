//
//  ViewController.swift
//  NetPromoterScoreSurveyExample
//
//  Created by Tomer Shalom on 28/09/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit
import ADNetPromoterScoreSurvey

class ViewController: UIViewController {

    var npsSurvery : ADNetPromoterScoreSurvey? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.npsSurvery = ADNetPromoterScoreSurvey()
        
        // Setup your own text
        self.npsSurvery?.appearance.scoreQuestionViewAppearance.questionText = "How likely are you to recommend My Awesome app to a friend or colleague?"
        self.npsSurvery?.appearance.feedbackQuestionViewAppearance.sendButtonTitle = "Done"
        
        // Setup your own colors
        self.npsSurvery?.appearance.scoreQuestionViewAppearance.questionTextColor = UIColor.blue
        self.npsSurvery?.appearance.feedbackQuestionViewAppearance.textFieldFontColor = UIColor.yellow
        self.npsSurvery?.appearance.thankYouViewAppearance.bottomBannerColor = UIColor.red
        
        // Implement NPS delegate
        self.npsSurvery?.delegate = self
    }
    
    @IBAction func showSurveyPressed(_ sender: Any) {
        
        self.npsSurvery?.showSurvey(onViewController: self)
    }
}

extension ViewController : NetPromoterScoreSurveyDelegate{
    
    func netPromoterScoreViewDidChange(_ npsSurvey: ADNetPromoterScoreSurvey, toView: NetPromoterScoreViewType){

        debugPrint("NetPromoterScoreSurveyDelegate netPromoterScoreViewDidChange toView: \(toView.rawValue)")
    }

    func netPromoterScoreDidPressSendScore(_ npsSurvey: ADNetPromoterScoreSurvey, selectedScore: Int){

        debugPrint("NetPromoterScoreSurveyDelegate netPromoterScoreDidPressSendScore selectedScore = \(selectedScore)")
    }

    func netPromoterScoreDidChangeScoreValue(_ npsSurvey: ADNetPromoterScoreSurvey, newScoreValue: Int){

        debugPrint("NetPromoterScoreSurveyDelegate netPromoterScoreDidChangeScoreValue newScoreValue = \(newScoreValue)")
    }

    func netPromoterScoreDidPressEditScore(_ npsSurvey: ADNetPromoterScoreSurvey){

        debugPrint("NetPromoterScoreSurveyDelegate netPromoterScoreDidPressEditScore")
    }

    func netPromoterScoreSurveryCompleted(_ npsSurvey: ADNetPromoterScoreSurvey, surveyResult: NPSResult){

        debugPrint("NetPromoterScoreSurveyDelegate netPromoterScoreSurveryCompleted finalScore: \(surveyResult.score) feedback: \(String(describing: surveyResult.feedback)) promoter: \(surveyResult.promoterType)")
    }

    func netPromoterScoreDidPressClose(_ npsSurvey: ADNetPromoterScoreSurvey, fromView: NetPromoterScoreViewType){

        debugPrint("NetPromoterScoreSurveyDelegate netPromoterScoreDidPressClose fromView: \(fromView.rawValue)")
    }
}
