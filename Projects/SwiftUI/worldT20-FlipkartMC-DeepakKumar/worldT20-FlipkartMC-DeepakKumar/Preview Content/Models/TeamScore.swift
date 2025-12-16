//
//  TeamScore.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//

import Foundation

struct TeamScore {
    var score: Int
    var wicket: Int
    var balls: Int
    
    var overs: String {
        return "\(balls/6).\(balls%6 )"
    }
}
