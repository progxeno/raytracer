//
//  XZRect.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class XZRect : Hitable {
    let x0: Double
    let x1: Double
    let z0: Double
    let z1: Double
    let k: Double
    let material: Material
    
    init(x0: Double, x1: Double, z0: Double, z1: Double, k: Double, material: Material) {
        self.x0 = x0
        self.x1 = x1
        self.z0 = z0
        self.z1 = z1
        self.k = k
        self.material = material
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        let t = (k - r.origin.y) / r.direction.y
        
        if (t < t_min || t > t_max) {
            return nil
        }
        
        let x = r.origin.x + t * r.direction.x
        let z = r.origin.z + t * r.direction.z
        
        if (x < x0 || x > x1 || z < z0 || z > z1) {
            return nil
        }
        
        return HitRecord(
            t: t,
            p: r.point_at_parameter(t: t),
            u: (x - x0) / (x1 - x0),
            v: (z - z0) / (z1 - z0),
            normal: Vec3(x: 0, y: 1, z: 0),
            material: material
        )
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: Vec3(x: x0, y: k - 0.0001, z: z0), max: Vec3(x: x1, y: k + 0.0001, z: z1))
    }
}
