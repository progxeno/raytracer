//
//  Random.swift
//  SwiftRay
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

func random01() -> Double {
    return Double(arc4random())/Double(UInt32.max)
}

func randomMinus1Plus1() -> Double {
    return 2.0 * random01() - 1.0
}

func randomPointInsideUnitSphere() -> Vec3 {
    let radius = random01()
    return radius * normalize(Vec3(x: randomMinus1Plus1(), y: randomMinus1Plus1(), z: randomMinus1Plus1()))
}

