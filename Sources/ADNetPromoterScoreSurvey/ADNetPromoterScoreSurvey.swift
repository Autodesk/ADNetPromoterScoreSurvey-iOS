//
//  ADNetPromoterScoreSurvey.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 28/09/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

@objc public enum NetPromoterScoreViewType: Int {
    
    case scoreQuestionView
    case feedbackQuestionView
    case thankYouView
}

@objc public enum NetPromoterType: Int {
    
    case unknown
    case promoter
    case passive
    case detractor
}

@objcMembers public class ADNetPromoterScoreSurvey : NSObject
{
    public weak var delegate : NetPromoterScoreSurveyDelegate?
    public var appearance    : NPSAppearance
    
    public var currentSelectedScore: Int{
        
        get{
            
            return self.lastSelectedScore
        }
    }
    
    public var currentSelectedNetPromoterType : NetPromoterType{
        
        get{
            
            return self.getPromoterType(forScore: self.currentSelectedScore)
        }
    }
    
    fileprivate var surveyView          : NPSSurveyViewProtocol?
    fileprivate var lastSelectedScore   : Int = -1
    
    public override init() {
        
        self.appearance = NPSAppearance.default
        super.init()
        self.initSurveyView()
    }
    
    internal convenience init?(customSurveyView: NPSSurveyViewProtocol){
        
        self.init()
        self.surveyView = customSurveyView
    }
    
    @objc public func showSurvey(onViewController viewController: UIViewController){
        
        self.surveyView?.showSurvey(onViewController: viewController)
    }
    
    @objc public func closeSurvey(){
        
        self.surveyView?.closeSurvey()
    }
    
    fileprivate func initSurveyView(){
        
        let bundle = Bundle(for: ADNetPromoterScoreSurvey.self)
        let nib = UINib(nibName: "NPSSurveyView", bundle: bundle)
        
        if let surveyView = nib.instantiate(withOwner: nil, options: nil).first as? NPSSurveyView{
            
            surveyView.translatesAutoresizingMaskIntoConstraints = false
            
            self.surveyView = surveyView
            self.surveyView!.delegate = self
        }
    }
    
    fileprivate func getPromoterType(forScore: Int) -> NetPromoterType{
        
        switch forScore {
        case 0...6:
            return .detractor
            
        case 7...8:
            return .passive
            
        case 9...10:
            return .promoter
            
        default:
            return .unknown
        }
    }
}

// MARK: --- NPSSurveyViewDelegate Implementation ---
extension ADNetPromoterScoreSurvey : NPSSurveyViewDelegate{

    func surveyViewDidPressClose(_ surveyView: NPSSurveyViewProtocol, fromView: NetPromoterScoreViewType){
        
        self.delegate?.netPromoterScoreDidPressClose?(self, fromView: fromView)
        self.surveyView?.closeSurvey()
    }
    
    func surveyViewScoreSliderValueDidChange(_ surveyView: NPSSurveyViewProtocol, newValue: Int){
        
        self.lastSelectedScore = newValue
        self.delegate?.netPromoterScoreDidChangeScoreValue?(self, newScoreValue: newValue)
    }
    
    func surveyViewDidSendScore(_ surveyView: NPSSurveyViewProtocol, score: Int){
        
        self.lastSelectedScore = score
        self.delegate?.netPromoterScoreDidPressSendScore?(self, selectedScore: score)
        self.surveyView?.continueToSendDetailsView(promoterType: getPromoterType(forScore: score))
    }
    
    func surveyViewDidPressEditScore(_ surveyView: NPSSurveyViewProtocol){
        
        self.delegate?.netPromoterScoreDidPressEditScore?(self)
        self.surveyView?.backToSendScoreView()
    }
    
    func surveyViewDidPressSendFeedback(_ surveyView: NPSSurveyViewProtocol, feedbackText: String){
        
        let finalResult = NPSResult(finalScore:   self.lastSelectedScore,
                                    feedbackText: feedbackText,
                                    promoterType: self.getPromoterType(forScore: self.lastSelectedScore))
        
        self.delegate?.netPromoterScoreSurveryCompleted?(self, surveyResult: finalResult)
        self.surveyView?.showThankYouView()
    }
    
    func surveyViewAppearance(_ surveyView: NPSSurveyViewProtocol, forView: NetPromoterScoreViewType) -> NPSAppearance {
        
        return self.appearance
    }
    
    func surveyViewDidChange(_ surveyView: NPSSurveyViewProtocol, toView viewType: NetPromoterScoreViewType) {
        
        self.delegate?.netPromoterScoreViewDidChange?(self, toView: viewType)
    }
}
