//
//  NPSResult.swift
//  ADNetPromoterScoreSurvey
//
//  Created by Tomer Shalom on 08/10/2017.
//  Copyright © 2017 Autodesk. All rights reserved.
//

import UIKit

public class NPSResult : NSObject{

    public var score: Int
    public var feedback: String?
    public var promoterType: NetPromoterType
    
    init(finalScore: Int, feedbackText: String?, promoterType: NetPromoterType) {
        
        self.score          = finalScore
        self.feedback       = feedbackText
        self.promoterType   = promoterType
    }
}
