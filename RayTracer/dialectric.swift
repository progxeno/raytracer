//
//  Dialectric.swiftr.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 04.01.18.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class Dielectric: Material {
    var ref_idx: Double
    
    init(index: Double) {
        ref_idx = index
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, _ attenuation: inout Vec3, _ scattered: inout Ray) -> Bool {
        var outward_normal = Vec3(x: 0, y: 0, z: 0)
        let reflected = r_in.direction.reflect(v2: rec.normal)
        var ni_over_nt = 1.0
        
        attenuation = Vec3(x: 1, y: 1, z: 1)
        
        var refracted = Vec3(x: 0, y: 0, z: 0)
        var reflect_prob = 0.0
        var cosine = 0.0
        
        if r_in.direction.dot(v2: rec.normal) > 0 {
            outward_normal = Vec3(x: -rec.normal.x, y: -rec.normal.y, z: -rec.normal.z) //-rec.normal
            ni_over_nt = ref_idx
            cosine = ref_idx * r_in.direction.dot(v2: rec.normal) / r_in.direction.length
        }
        else {
            outward_normal = rec.normal
            ni_over_nt = 1.0 / ref_idx
            cosine = -r_in.direction.dot(v2: rec.normal) / r_in.direction.length
        }
        
        if refract(v: r_in.direction, n: outward_normal, ni_over_nt: ni_over_nt, refracted: &refracted) {
            reflect_prob = schlick(cosine: cosine, ref_idx: ref_idx)
        }
        else {
            reflect_prob = 1.0
        }
        
        if drand48() < reflect_prob {
            scattered = Ray(origin: rec.p, direction: reflected, time: r_in.time)
        }
        else {
            scattered = Ray(origin: rec.p, direction: refracted, time: r_in.time)
        }
        
        return true
    }
    
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3 {
        return Vec3(x: 0.0, y: 0.0, z: 0.0)
    }
}

func refract(v: Vec3, n: Vec3, ni_over_nt: Double,  refracted: inout Vec3) -> Bool {
    let uv = v.unit_vector()
    let dt = uv.dot(v2: n)
    let discrim = 1.0 - ni_over_nt*ni_over_nt * (1.0 - dt*dt)
    
    if discrim > 0 {
        refracted = ni_over_nt * (uv - n * dt) - n * sqrt(discrim)
        return true
    }
    else {
        return false
    }
}

func schlick(cosine: Double, ref_idx: Double) -> Double {
    var r0 = (1.0 - ref_idx) / (1.0 + ref_idx)
    
    r0 = r0 * r0
    
    return r0 + (1.0 - r0) * pow((1.0 - cosine), 5)
}
