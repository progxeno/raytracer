//
//  Ray.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class Ray : CustomStringConvertible {
    var origin: Vec3
    var direction: Vec3
    var time: Double
    
    init(origin: Vec3, direction: Vec3, time: Double) {
        self.origin = origin
        self.direction = direction
        self.time = time
    }
    
    var description: String {
        return "origin: \(origin), direction: \(direction), time: \(time)"
    }
    
    func point_at_parameter(t: Double) -> Vec3 {
        return origin + t * direction
    }
}
