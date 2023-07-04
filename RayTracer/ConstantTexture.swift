//
//  ConstantTexture.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class ConstantTexture : Texture {
    let color: Vec3
    
    init(color: Vec3) {
        self.color = color
    }
    
    func value(u: Double, _ v: Double, _ p: Vec3) -> Vec3 {
        return color
    }
}
