//
//  NPSSurveyViewProtocol.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 01/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

protocol NPSSurveyViewProtocol {
    
    var delegate : NPSSurveyViewDelegate? {get set}
    
    func showSurvey(onViewController viewController: UIViewController)
    func closeSurvey()
    
    func continueToSendDetailsView(promoterType: NetPromoterType)
    func backToSendScoreView()
    func showThankYouView()
}
