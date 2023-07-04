//
//  XYRect.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class XYRect : Hitable {
    let x0: Double
    let x1: Double
    let y0: Double
    let y1: Double
    let k: Double
    let material: Material
    
    init(x0: Double, x1: Double, y0: Double, y1: Double, k: Double, material: Material) {
        self.x0 = x0
        self.x1 = x1
        self.y0 = y0
        self.y1 = y1
        self.k = k
        self.material = material
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        let t = (k - r.origin.z) / r.direction.z
        
        if (t < t_min || t > t_max) {
            return nil
        }
        
        let x = r.origin.x + t * r.direction.x
        let y = r.origin.y + t * r.direction.y
        
        if (x < x0 || x > x1 || y < y0 || y > y1) {
            return nil
        }
        
        return HitRecord(
            t: t,
            p: r.point_at_parameter(t: t),
            u: (x - x0) / (x1 - x0),
            v: (y - y0) / (y1 - y0),
            normal: Vec3(x: 0, y: 0, z: 1),
            material: material
        )
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: Vec3(x: x0, y: y0, z: k - 0.0001), max: Vec3(x: x1, y: y1, z: k + 0.0001))
    }
}
