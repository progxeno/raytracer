//
//  YZRect.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class YZRect : Hitable {
    let y0: Double
    let y1: Double
    let z0: Double
    let z1: Double
    let k: Double
    let material: Material
    
    init(y0: Double, y1: Double, z0: Double, z1: Double, k: Double, material: Material) {
        self.y0 = y0
        self.y1 = y1
        self.z0 = z0
        self.z1 = z1
        self.k = k
        self.material = material
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        let t = (k - r.origin.x) / r.direction.x
        
        if (t < t_min || t > t_max) {
            return nil
        }
        
        let y = r.origin.y + t * r.direction.y
        let z = r.origin.z + t * r.direction.z
        
        if (y < y0 || y > y1 || z < z0 || z > z1) {
            return nil
        }
        
        return HitRecord(
            t: t,
            p: r.point_at_parameter(t: t),
            u: (y - y0) / (y1 - y0),
            v: (z - z0) / (z1 - z0),
            normal: Vec3(x: 1, y: 0, z: 0),
            material: material
        )
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: Vec3(x: k - 0.0001, y: y0, z: z0), max: Vec3(x: k + 0.0001, y: y1, z: z1))
    }
}
