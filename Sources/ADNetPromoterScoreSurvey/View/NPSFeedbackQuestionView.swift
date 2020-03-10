//
//  NPSFeedbackQuestionView.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 03/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

class NPSFeedbackQuestionView: NPSBaseView {

    weak var delegate : NPSFeedbackQuestionViewDelegate?
    
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
    
    @IBOutlet weak var feedbackTextView: NPSFeedbackTextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var sendButton: NPSSendButton!
    @IBOutlet weak var contentViewToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTopToSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.bindToKeyboard()
        self.feedbackTextView.layer.borderWidth = 1.0
        
        self.feedbackTextView.layer.borderColor = UIColor(red: 193.0/255.0, green: 193.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.editButton.titleLabel?.lineBreakMode = .byWordWrapping
        self.editButton.titleLabel?.numberOfLines = 2
        self.editButton.titleLabel?.textAlignment = .center
    }
    
    override func setupTexts() {
        
        super.setupTexts()
        
        self.editButton.setTitle(self.appearance.feedbackQuestionViewAppearance.editScoreButtonTitle, for: .normal)
        self.sendButton.setTitle(self.appearance.feedbackQuestionViewAppearance.sendButtonTitle, for: .normal)  
    }
    
    override func setupFonts() {
        
        super.setupFonts()
        
        let feedbackQuestionViewAppearance = self.appearance.feedbackQuestionViewAppearance
        
        self.titleLabel.font                    = feedbackQuestionViewAppearance.titleFont ?? self.titleLabel.font
        self.feedbackTextView.placeholderFont   = feedbackQuestionViewAppearance.placeholderFont ?? self.feedbackTextView.placeholderFont
        self.feedbackTextView.font              = feedbackQuestionViewAppearance.textFieldFont ?? self.feedbackTextView.font
        self.sendButton.titleLabel?.font        = feedbackQuestionViewAppearance.sendButtonTitleFont ?? self.sendButton.titleLabel?.font
        self.editButton.titleLabel?.font        = feedbackQuestionViewAppearance.editScoreButtonTitleFont ?? self.editButton.titleLabel?.font
    }

    override func setupColors() {
        
        super.setupColors()
        
        let feedbackQuestionViewAppearance = self.appearance.feedbackQuestionViewAppearance
        self.contentView.backgroundColor        = feedbackQuestionViewAppearance.backgroundColor ?? self.contentView.backgroundColor
        self.titleLabel.textColor               = feedbackQuestionViewAppearance.titleFontColor ?? self.titleLabel.textColor
        self.feedbackTextView.textColor         = feedbackQuestionViewAppearance.textFieldFontColor ?? self.feedbackTextView.textColor
        self.feedbackTextView.placeholderColor  = feedbackQuestionViewAppearance.placehoderFontColor ?? self.feedbackTextView.placeholderColor
        self.sendButton.backgroundColor         = feedbackQuestionViewAppearance.sendButtonBackgroundColor ?? self.sendButton.backgroundColor
        self.feedbackTextView.backgroundColor   = feedbackQuestionViewAppearance.feedbackTextBlackgroundColor ?? self.feedbackTextView.backgroundColor
        
        self.editButton.setTitleColor(feedbackQuestionViewAppearance.editScoreButtonTextColor ?? self.editButton.titleLabel?.textColor, for: .normal)
        self.sendButton.setTitleColor(feedbackQuestionViewAppearance.sendButtonTitleColor ?? self.sendButton.titleLabel?.textColor, for: .normal)
    }
    
    override func animateIn(withDuration duration: TimeInterval, completionBlock : (() -> ())?){
        
        self.initAnimateInStartPositions()
        
        self.contentViewToBottomConstraint.constant = 0
        self.contentViewTopToSafeAreaConstraint.constant = 285
        
        UIView.animate(withDuration: duration, animations: {
            
            self.layoutIfNeeded()
        },completion:{ (finished) in
            
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
        self.delegate?.moreDetailsViewDidPressClose(self)
    }
    
    func updateUI(forPromoter : NetPromoterType){
        
        switch forPromoter {
        case .detractor:
            
            self.titleLabel.text                = self.appearance.feedbackQuestionViewAppearance.titleForDetractor
            self.feedbackTextView.placeholder   = self.appearance.feedbackQuestionViewAppearance.placeholderForDetractor
            break
            
        case .passive:
            
            self.titleLabel.text                = self.appearance.feedbackQuestionViewAppearance.titleForPassive
            self.feedbackTextView.placeholder   = self.appearance.feedbackQuestionViewAppearance.placeholderForPassive
            break
            
        case .promoter:
            
            self.titleLabel.text                = self.appearance.feedbackQuestionViewAppearance.titleForPromoter
            self.feedbackTextView.placeholder   = self.appearance.feedbackQuestionViewAppearance.placeholderForPromoter
            break
            
        default:
            self.titleLabel.text                = self.appearance.feedbackQuestionViewAppearance.titleForPassive
            self.feedbackTextView.placeholder   = self.appearance.feedbackQuestionViewAppearance.placeholderForPassive
            break
        }
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismissKeyboard()
        self.delegate?.moreDetailsViewDidPressClose(self)
    }
    
    @IBAction func editScore(_ sender: Any) {
        
        self.dismissKeyboard()
        self.delegate?.moreDetailsViewDidPressEditScore(self)
    }
    
    @IBAction func send(_ sender: Any) {
        
        self.dismissKeyboard()
        self.delegate?.moreDetailsViewDidPressSend(self, text: self.feedbackTextView.text)
    }
    
    private func initAnimateInStartPositions(){
        
        self.contentViewToBottomConstraint.constant = animateInStartYLocation
        self.contentViewTopToSafeAreaConstraint.constant = self.animateInTopToSafeAreaStartLocation
        self.layoutIfNeeded()
    }
    
    fileprivate func bindToKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    fileprivate func unbindFromKeyboard(){
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        
        self.endEditing(true)
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        // Animate view up only if the vertical size is bigger then compact
        guard self.traitCollection.verticalSizeClass != .compact else { return }
        
        guard let userInfo = notification.userInfo else { return }
        
        let duration    = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve       = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let targetFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let newY        = targetFrame.origin.y-self.frame.height
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            
            self.frame.origin.y = newY
        })
    }
    
    deinit {
        
        self.unbindFromKeyboard()
    }
}
