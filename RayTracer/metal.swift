//
//  Metal.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class Metal: Material {
    var albedo: Vec3
    var fuzz: Double
    
    init(a: Vec3, f: Double) {
        albedo = a
        fuzz = f < 1 ? f : 1
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, _ attenuation: inout Vec3, _ scattered: inout Ray) -> Bool {
        let reflected = r_in.direction.unit_vector().reflect(v2: rec.normal)
        
        scattered = Ray(origin: rec.p, direction: reflected + fuzz * random_in_unit_sphere(), time: r_in.time)
        attenuation = albedo
        
        return scattered.direction.dot(v2: rec.normal) > 0
    }
    
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3 {
        return Vec3(x: 0.0, y: 0.0, z: 0.0)
    }
}
