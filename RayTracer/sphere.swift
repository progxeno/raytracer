//
//  Sphere.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class Sphere: Hitable  {
    var center = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var radius = 0.0
    var material: Material
    
    init(c: Vec3, r: Double, m: Material) {
        center = c
        radius = r
        material = m
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        let oc = r.origin - center
        let a = r.direction.squared_length
        let b = oc.dot(v2: r.direction)
        let c = oc.squared_length - radius*radius
        let discrim = sqrt(b*b - a*c)
        
        if discrim > 0 {
            var temp = (-b - discrim) / a
            
            if temp < t_max && temp > t_min {
                let point = r.point_at_parameter(t: temp)
                let uv = getSphereUV(p: (point - center) / radius)
                
                return HitRecord(t: temp, p: point, u: uv.0, v: uv.1, normal: (point - center) / radius, material: material)
            }
            
            temp = (-b + discrim) / a
            
            if temp < t_max && temp > t_min {
                let point = r.point_at_parameter(t: temp)
                let uv = getSphereUV(p: (point - center) / radius)
                
                return HitRecord(t: temp, p: point, u: uv.0, v: uv.1, normal: (point - center) / radius, material: material)
            }
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: center - Vec3(x: radius, y: radius, z: radius), max: center + Vec3(x: radius, y: radius, z: radius))
    }
}

func getSphereUV(p: Vec3) -> (Double, Double) {
    let phi = atan2(p.z, p.x)
    let theta = asin(p.y)
    
    return (
        1.0 - (phi + Double.pi) / (2.0 * Double.pi),
        (theta + Double.pi/2.0) / Double.pi
    )
}
