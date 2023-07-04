//
//  FlipNormal.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class FlipNormal : Hitable {
    let ptr: Hitable
    
    init(ptr: Hitable) {
        self.ptr = ptr
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        if let rec = ptr.hit(r: r, t_min, t_max) {
            rec.normal = -rec.normal
            
            return rec
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return ptr.boundingBox(t0: t0, t1)
    }
}
