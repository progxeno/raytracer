//
//  Lambertian.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class Lambertian: Material {
    var albedo: Texture
    
    init(a: Texture) {
        albedo = a
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, _ attenuation: inout Vec3, _ scattered: inout Ray) -> Bool {
        let target = rec.p + rec.normal + random_in_unit_sphere()
        
        scattered = Ray(origin: rec.p, direction: target - rec.p, time: r_in.time)
        attenuation = albedo.value(u: rec.u, rec.v, rec.p)
        
        return true
    }
    
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3 {
        return Vec3(x: 0.0, y: 0.0, z: 0.0)
    }
}
