//
//  NPSScoreQuestionView.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 01/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

class NPSScoreQuestionView: NPSBaseView {
    
    weak var delegate : NPSScoreQuestionViewDelegate?
    
    fileprivate lazy var animateInStartYLocation: CGFloat = {
        
        return -(self.contentView.frame.height + self.closeButtonContentViewHeightAddition)
    }()
    
    fileprivate lazy var animateInTopToSafeAreaStartLocation: CGFloat = {
        
        var safeAreaBottomHeight: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            safeAreaBottomHeight = self.safeAreaInsets.bottom
        }
        return -(safeAreaBottomHeight + self.closeButtonContentViewHeightAddition)
    }()
    
    fileprivate var scoreLabels : [UILabel] = []
    
    @IBOutlet weak var scoresLabelsView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var sendButton: NPSSendButton!
    @IBOutlet weak var contentViewToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTopToSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scoreSlider: NPSSlider!
    @IBOutlet weak var notLikelyLabel: UILabel!
    @IBOutlet weak var veryLikelyLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.setupScoresLabels()

        self.scoreSlider.delegate = self
    }
    
    override func setupTexts() {
        
        super.setupTexts()
        
        self.questionLabel.text     = self.appearance.scoreQuestionViewAppearance.questionText
        self.notLikelyLabel.text    = self.appearance.scoreQuestionViewAppearance.lowRankTitle
        self.veryLikelyLabel.text   = self.appearance.scoreQuestionViewAppearance.highRankTitle
        
        sendButton.setTitle(self.appearance.scoreQuestionViewAppearance.sendButtonTitle,for: .normal)
    }
    
    override func setupColors() {
        
        super.setupColors()
        
        let scoreQuestionViewAppearance = self.appearance.scoreQuestionViewAppearance
        
        self.contentView.backgroundColor    = scoreQuestionViewAppearance.backgroundColor ?? self.contentView.backgroundColor
        self.questionLabel.textColor        = scoreQuestionViewAppearance.questionTextColor ?? questionLabel.textColor
        self.sendButton.backgroundColor     = scoreQuestionViewAppearance.sendButtonBackgroundColor ?? self.sendButton.backgroundColor
        self.notLikelyLabel.textColor       = scoreQuestionViewAppearance.lowRankTitleColor ?? self.notLikelyLabel.textColor
        self.veryLikelyLabel.textColor      = scoreQuestionViewAppearance.highRankTitleColor ?? self.veryLikelyLabel.textColor
        
        self.scoreSlider.maximumTrackTicksColor         = scoreQuestionViewAppearance.sliderMaximumTrackTicksColor ?? self.scoreSlider.maximumTrackTicksColor
        self.scoreSlider.minimumTrackTicksColor         = scoreQuestionViewAppearance.sliderMinimumTrackTicksColor ?? self.scoreSlider.minimumTrackTicksColor
        self.scoreSlider.thumbTintColor                 = scoreQuestionViewAppearance.sliderThumbColor ?? self.scoreSlider.thumbTintColor
        self.scoreSlider.minimumTrackBackgroundColor    = scoreQuestionViewAppearance.sliderMinimumTrackBackgroundColor ?? self.scoreSlider.minimumTrackBackgroundColor
        self.scoreSlider.backgroundColor                = scoreQuestionViewAppearance.sliderBackgroundColor ?? self.scoreSlider.backgroundColor
                
        if let sendButtonTitleColor = scoreQuestionViewAppearance.sendButtonTextColor{
            self.sendButton.setTitleColor(sendButtonTitleColor, for: .normal)
        }
    }
    override func setupFonts(){
        
        super.setupFonts()
        
        let scoreQuestionViewAppearance = self.appearance.scoreQuestionViewAppearance
        
        self.questionLabel.font             = scoreQuestionViewAppearance.questionTextFont ?? self.questionLabel.font
        self.notLikelyLabel.font            = scoreQuestionViewAppearance.lowRankTitleFont ?? self.notLikelyLabel.font
        self.veryLikelyLabel.font           = scoreQuestionViewAppearance.highRankTitleFont ?? self.veryLikelyLabel.font
        self.sendButton.titleLabel?.font    = scoreQuestionViewAppearance.sendButtonTitleFont ?? self.sendButton.titleLabel?.font
    }
    
    private func setupScoresLabels(){
        
        self.scoresLabelsView.axis          = .horizontal
        self.scoresLabelsView.distribution  = .equalSpacing
        self.scoresLabelsView.alignment     = .center
        
        for currentScore in 0...10{
            
            let currentLabel = UILabel()
            currentLabel.text   = "\(currentScore)"
            currentLabel.tag    = currentScore
            
            if let scoreFont = self.appearance.scoreQuestionViewAppearance.scoresTextFont{
                
                currentLabel.font = scoreFont
            }
            
            currentLabel.textColor = self.appearance.scoreQuestionViewAppearance.scoresTextColor ?? currentLabel.textColor
            
            self.scoreLabels.append(currentLabel)
            self.scoresLabelsView.addArrangedSubview(currentLabel)
        }
    }
    
    @IBAction func send(_ sender: Any) {
        
        guard scoreSlider.value != nil else { return }
        let scoreValue = self.scoreSlider.value!
        self.delegate?.scoreQuestionViewDidPressSend(self, selectedScore: scoreValue)
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.delegate?.scoreQuestionViewDidPressClose(self)
    }
    
    override func animateIn(withDuration duration: TimeInterval, completionBlock : (() -> ())?){
        
        self.initAnimateInStartPositions()
        
        self.contentViewToBottomConstraint.constant = 0
        self.contentViewTopToSafeAreaConstraint.constant = 285
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            
            self.layoutIfNeeded()
        },
                       completion: { (finished) in
            
            completionBlock?()
        })
    }
    
    override func animateOut(withDuration duration: TimeInterval, completionBlock : (() -> ())?){

        self.contentViewToBottomConstraint.constant = animateInStartYLocation
        self.contentViewTopToSafeAreaConstraint.constant = self.animateInTopToSafeAreaStartLocation
        
        UIView.animate(withDuration: duration, animations: {
            
            self.layoutIfNeeded()
        },completion:{ (finished) in
            
            if (finished){
                completionBlock?()
            }
            
        })
    }
    
    override func handleSwipeDownGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        super.handleSwipeDownGesture(gesture: gesture)
        self.delegate?.scoreQuestionViewDidPressClose(self)
    }
    
    private func initAnimateInStartPositions(){
        
        self.contentViewToBottomConstraint.constant = animateInStartYLocation
        self.contentViewTopToSafeAreaConstraint.constant = self.animateInTopToSafeAreaStartLocation
        self.layoutIfNeeded()
    }
}

// MARK: --- Private functions ---
extension NPSScoreQuestionView{
    
    fileprivate func updateScoresColor(forScore score: Int?){
        
        for currentLabel in self.scoreLabels{
            
            currentLabel.textColor = UIColor.black
            currentLabel.font = self.appearance.scoreQuestionViewAppearance.scoresTextFont ?? currentLabel.font
            currentLabel.textColor = self.appearance.scoreQuestionViewAppearance.scoresTextColor ?? currentLabel.textColor
            
            if (score != nil && currentLabel.tag == score){
                
                currentLabel.textColor = UIColor(red:   0.0/255.0,
                                                 green: 150.0/255.0,
                                                 blue:  220.0/255.0,
                                                 alpha: 1.0)
                
                currentLabel.font = self.appearance.scoreQuestionViewAppearance.selectedScoreTextFont ?? currentLabel.font
                currentLabel.textColor = self.appearance.scoreQuestionViewAppearance.selectedScoreTextColor ?? currentLabel.textColor
            }
        }
    }
    
    fileprivate func updateLowAndHighLabels(forScore score: Int?){
        
        // Rest to default font
        self.notLikelyLabel.font        = self.appearance.scoreQuestionViewAppearance.lowRankTitleFont ?? self.notLikelyLabel.font
        self.veryLikelyLabel.font       = self.appearance.scoreQuestionViewAppearance.highRankTitleFont ?? self.veryLikelyLabel.font
        
        // Rest to default colors
        self.notLikelyLabel.textColor   = self.appearance.scoreQuestionViewAppearance.lowRankTitleColor ?? UIColor(red:   148.0/255.0,
                                                                                                                   green: 148.0/255.0,
                                                                                                                   blue:  148.0/255.0,
                                                                                                                   alpha: 1.0)
    
        self.veryLikelyLabel.textColor  = self.appearance.scoreQuestionViewAppearance.highRankTitleColor ?? UIColor(red:   148.0/255.0,
                                                                                                                    green: 148.0/255.0,
                                                                                                                    blue:  148.0/255.0,
                                                                                                                    alpha: 1.0)
        
        
        // Update fonts and colors if needed
        if (score != nil){
            
            if (score! >= 0 && score! <= 6){
                
                self.notLikelyLabel.textColor = UIColor(red:   0.0/255.0,
                                                        green: 150.0/255.0,
                                                        blue:  220.0/255.0,
                                                        alpha: 1.0)
                
                if let _ = self.appearance.scoreQuestionViewAppearance.lowRankTitleMarkedFont {
                    
                    self.notLikelyLabel.font = self.appearance.scoreQuestionViewAppearance.lowRankTitleMarkedFont
                }
                self.notLikelyLabel.textColor = self.appearance.scoreQuestionViewAppearance.lowRankTitleMarkedColor ?? self.notLikelyLabel.textColor
            }
            else if(score! >= 9 && score! <= 10){
                
                self.veryLikelyLabel.textColor = UIColor(red:   0.0/255.0,
                                                         green: 150.0/255.0,
                                                         blue:  220.0/255.0,
                                                         alpha: 1.0)
                
                if let _ = self.appearance.scoreQuestionViewAppearance.highRankTitleMarkedFont  {
                    
                    self.veryLikelyLabel.font = self.appearance.scoreQuestionViewAppearance.highRankTitleMarkedFont
                }
                self.veryLikelyLabel.textColor = self.appearance.scoreQuestionViewAppearance.highRankTitleMarkedColor ?? self.veryLikelyLabel.textColor
            }
        }
    }
    
    fileprivate func updateUIWithScore(newScore: Int?){
        
        self.updateScoresColor(forScore: newScore)
        self.updateLowAndHighLabels(forScore: newScore)
        
        if (newScore != nil && !self.sendButton.isEnabled){
            
            self.sendButton.isEnabled       = true
            self.sendButton.backgroundColor = self.appearance.scoreQuestionViewAppearance.sendButtonBackgroundColor ?? UIColor(red: 0.0/255.0,
                                                                                                                               green: 150.0/255.0,
                                                                                                                               blue: 220.0/255.0,
                                                                                                                               alpha: 1)
        }
    }
}

// MARK: --- NPSSliderDelegate Implementation ---
extension NPSScoreQuestionView : NPSSliderDelegate{

    func sliderValueDidChange(_ slider:NPSSlider,value:Int?){
        
        self.updateUIWithScore(newScore: value)
        
        if let _ = value{
            
            self.delegate?.scoreQuestionViewDidChangeScoreValue(self, newValue: value!)
        }
    }
    
    func sliderValueWillChange(_ slider:NPSSlider,value:Int?){
        
        self.updateUIWithScore(newScore: value)
    }
}
