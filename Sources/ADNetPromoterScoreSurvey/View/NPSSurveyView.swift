//
//  NPSSurveyView.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 28/09/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

fileprivate extension UIView
{
    func fillWithView(_ view: UIView){
        
        let viewDict = ["view" : view]
        
        let horisontalFormat    = "H:|[view]|"
        let verticalFormat      = "V:|[view]|"
        let priority            = UILayoutPriority.required
        
        let horisontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: horisontalFormat,
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: viewDict)
        for currConstraint in horisontalConstraints{
            
            currConstraint.priority = priority
        }
        
        self.addConstraints(horisontalConstraints)
        
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: verticalFormat,
                                                                 options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: viewDict)
        for currConstraint in verticalConstraints{
            
            currConstraint.priority = priority
        }
        
        self.addConstraints(verticalConstraints)
        self.layoutIfNeeded()
    }
}

class NPSSurveyView: NPSBaseView
{
    weak var delegate : NPSSurveyViewDelegate?
    
    fileprivate var _scoreQuestionView: NPSScoreQuestionView?
    fileprivate var _feedbackQuestionView: NPSFeedbackQuestionView?
    fileprivate var _thankYouView: NPSThankYouView?

    fileprivate var scoreQuestionView: NPSScoreQuestionView? {
        
        get{
            
            if (_scoreQuestionView == nil){
                
                let bundle = Bundle(for: ADNetPromoterScoreSurvey.self)
                let nib = UINib(nibName: "NPSScoreQuestionView", bundle: bundle)
                
                _scoreQuestionView = nib.instantiate(withOwner: nil, options: nil).first as? NPSScoreQuestionView
                
                if let _ = _scoreQuestionView{
                    
                    _scoreQuestionView!.translatesAutoresizingMaskIntoConstraints = false
                    _scoreQuestionView!.delegate = self
                }
            }
            return _scoreQuestionView
        }
        set{
            
            _scoreQuestionView = newValue
        }
    }
    
    fileprivate var feedbackQuestionView: NPSFeedbackQuestionView? {
        
        get{
            
            if (_feedbackQuestionView == nil){
                
                let bundle          = Bundle(for: ADNetPromoterScoreSurvey.self)
                let nib             = UINib(nibName: "NPSFeedbackQuestionView", bundle: bundle)
                _feedbackQuestionView    = nib.instantiate(withOwner: nil, options: nil).first as? NPSFeedbackQuestionView
                
                if let _ = _feedbackQuestionView {
                    
                    _feedbackQuestionView!.translatesAutoresizingMaskIntoConstraints = false
                    _feedbackQuestionView!.delegate = self
                }
            }
            return _feedbackQuestionView
        }
        set{
            
            _feedbackQuestionView = newValue
        }
    }
    
    fileprivate var thankYouView: NPSThankYouView? {
        
        get{
            
            if (_thankYouView == nil){
                
                let bundle      = Bundle(for: ADNetPromoterScoreSurvey.self)
                let nib         = UINib(nibName: "NPSThankYouView", bundle: bundle)
                _thankYouView   = nib.instantiate(withOwner: nil, options: nil).first as? NPSThankYouView
                if let _ = _thankYouView {
                    
                    _thankYouView!.translatesAutoresizingMaskIntoConstraints = false
                    _thankYouView!.delegate = self
                }
            }
            return _thankYouView
        }
        set{
            
            _thankYouView = newValue
        }
    }
    
    fileprivate func showScoreQuestionView(){
        
        guard self.scoreQuestionView != nil else {
            
            return
        }

        if let viewAppearance = self.delegate?.surveyViewAppearance(self, forView: .scoreQuestionView){
            
            self.scoreQuestionView!.appearance = viewAppearance
        }
        
        self.addSubview(self.scoreQuestionView!)
        self.fillWithView(self.scoreQuestionView!)
        self.scoreQuestionView?.animateIn(withDuration: 0.4){
            
            self.delegate?.surveyViewDidChange(self, toView: .scoreQuestionView)
        }
    }
    
    fileprivate func showMoreDetailsView(){

        guard self.feedbackQuestionView != nil else {
            
            return
        }
        
        if let viewAppearance = self.delegate?.surveyViewAppearance(self, forView: .feedbackQuestionView){
            
            self.feedbackQuestionView!.appearance = viewAppearance
        }
        
        self.addSubview(self.feedbackQuestionView!)
        self.fillWithView(self.feedbackQuestionView!)
        self.feedbackQuestionView!.animateIn(withDuration: 0.3){
            
            self.delegate?.surveyViewDidChange(self, toView: .feedbackQuestionView)
        }
    }
}

// MARK: --- NPSSurveyViewProtocol Implementation ---
extension NPSSurveyView : NPSSurveyViewProtocol{

    
    func showSurvey(onViewController viewController: UIViewController) {

        self.alpha = 0
        
        viewController.view.addSubview(self)
        viewController.view.fillWithView(self)
        
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.alpha = 1
        },completion: nil)
        
        self.showScoreQuestionView()
    }
    
    func closeSurvey(){
        
        let clearViews = {
            
            // Remove from super view only if view were allocated
            if (self._scoreQuestionView != nil)     { self.scoreQuestionView?.removeFromSuperview() }
            if (self._feedbackQuestionView != nil)  { self.feedbackQuestionView?.removeFromSuperview() }
            if (self._thankYouView != nil)          { self.thankYouView?.removeFromSuperview() }

            self.scoreQuestionView      = nil
            self.feedbackQuestionView   = nil
            self.thankYouView           = nil
            
            self.removeFromSuperview()
        }
        
        if let currentView = self.getCurrentView(){
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { self.alpha = 0 },completion: nil)
            currentView.animateOut(withDuration: 0.3){
                
                clearViews()
            }
        }
        else{
            
            clearViews()
        }
    }
    
    func continueToSendDetailsView(promoterType: NetPromoterType){
        
        self.scoreQuestionView?.animateOut(withDuration: 0.2, completionBlock: {
            
            self.scoreQuestionView?.removeFromSuperview()
            self.feedbackQuestionView?.updateUI(forPromoter: promoterType)
            self.showMoreDetailsView()
        })
    }
    
    func backToSendScoreView(){
        
        self.feedbackQuestionView?.animateOut(withDuration: 0.3){
            
            self.showScoreQuestionView()
        }
        
    }
    
    func showThankYouView(){
        
        guard self.thankYouView != nil else {
            
            return
        }
        
        
        if let viewAppearance = self.delegate?.surveyViewAppearance(self, forView: .thankYouView){
            
            self.thankYouView!.appearance = viewAppearance
        }
        
        self.feedbackQuestionView?.animateOut(withDuration: 0.3){
            
            self.feedbackQuestionView?.removeFromSuperview()
            self.addSubview(self.thankYouView!)
            self.fillWithView(self.thankYouView!)
            
            self.thankYouView!.animateIn(withDuration: 0.27){
                
                self.delegate?.surveyViewDidChange(self, toView: .thankYouView)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                    
                    self.closeSurvey()
                }
            }
        }
    }
    
    func getCurrentView() -> NPSBaseView?{
        
        if (self._scoreQuestionView != nil && self.scoreQuestionView!.isCurrentlyPresented()){
            
            return self.scoreQuestionView
        }

        if (self._feedbackQuestionView != nil && self.feedbackQuestionView!.isCurrentlyPresented()){
            
            return self.feedbackQuestionView
        }
        
        if (self._thankYouView != nil && self.thankYouView!.isCurrentlyPresented()){
            
            return self.thankYouView
        }
        
        return nil
    }
}

// MARK: --- NPSScoreQuestionViewDelegate Implementation ---
extension NPSSurveyView : NPSScoreQuestionViewDelegate{
    
    func scoreQuestionViewDidPressClose(_ scoreQuestionView : NPSScoreQuestionView){
        
        self.delegate?.surveyViewDidPressClose(self, fromView: .scoreQuestionView)
    }
    
    func scoreQuestionViewDidPressSend(_ scoreQuestionView : NPSScoreQuestionView, selectedScore:Int){
        
        self.delegate?.surveyViewDidSendScore(self, score: selectedScore)
    }
    
    func scoreQuestionViewDidChangeScoreValue(_ scoreQuestionView : NPSScoreQuestionView,newValue:Int){
        
        self.delegate?.surveyViewScoreSliderValueDidChange(self, newValue: newValue)
    }
}

// MARK: --- NPSFeedbackQuestionViewDelegate Implementation ---
extension NPSSurveyView : NPSFeedbackQuestionViewDelegate{
    
    func moreDetailsViewDidPressClose(_ moreDetailsView: NPSFeedbackQuestionView){
        
        self.delegate?.surveyViewDidPressClose(self, fromView: .feedbackQuestionView)
    }
    
    func moreDetailsViewDidPressSend(_ moreDetailsView: NPSFeedbackQuestionView, text: String){
        
        self.delegate?.surveyViewDidPressSendFeedback(self, feedbackText: text)
    }
    
    func moreDetailsViewDidPressEditScore(_ moreDetailsView: NPSFeedbackQuestionView){
        
        self.delegate?.surveyViewDidPressEditScore(self)
    }
}

// MARK: --- NPSThankYouViewDelegate Implementation ---
extension NPSSurveyView : NPSThankYouViewDelegate{
    
    func thankYouViewDidPressClose(_ thankYouView: NPSThankYouView){
        
        self.delegate?.surveyViewDidPressClose(self, fromView: .thankYouView)
    }
}
