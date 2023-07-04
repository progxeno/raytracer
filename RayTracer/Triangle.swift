//
//  Triangles.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 22.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class Triangle: Hitable  {
    
    var center = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var radius = 0.0
    var material: Material
    var v0 = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var v1 = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var v2 = Vec3(x: 0.0, y: 0.0, z: 0.0)
    var normal = Vec3(x: 0.0, y: 0.0, z: 0.0)
    
    init(v0_: Vec3, v1_: Vec3, v2_: Vec3, m: Material) {
        v0 = v0_
        v1 = v1_
        v2 = v2_
        normal = (v1_ - v0_).cross(v2: (v2_ - v0_))
        material = m
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        var t, u, v: Double
        let v0v1 = v1 - v0
        let v0v2 = v2 - v0
        let pvec = r.direction.cross(v2: v0v2)
        
        let det = pvec.dot(v2: v0v1)
        let kEpsilon = 0.00001
    
        if det < kEpsilon {
            return nil
        }
        
        let invDet = 1/det
        let tvec = r.origin - v0
        u = (tvec.dot(v2: pvec)) * invDet
        
        if (u < 0 || u > 1) {
            return nil
        }
        let qvec = tvec.cross(v2: v0v1)
        v = (r.direction.dot(v2: qvec)) * invDet
        
        if v < 0 || u + v > 1 {
            return nil
        }
        
        t = v0v2.dot(v2: qvec) * invDet
        
        if t < 0 {
            return nil
        }
        
        let point = r.point_at_parameter(t: t)
        
        
       return HitRecord(t: t, p: point, u: 0.0, v: 0.0, normal: normal, material: material)
        
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        let min = getMin(v0: v0, v1: v1, v2: v2)
        let max = getMin(v0: v0, v1: v1, v2: v2)
        
        return AABB(min: min , max: max)
    }
    
    func getMin(v0 : Vec3, v1: Vec3, v2: Vec3) -> Vec3{
        var minVec = Vec3(x: 0.0, y: 0.0, z: 0.0)
        
        minVec.x = min(v0.x, v1.x, v2.x)
        minVec.y = min(v0.y, v1.y, v2.y)
        minVec.z = min(v0.z, v1.z, v2.z)
        
        return minVec
        
    }
    
    func getMax(v0 : Vec3, v1: Vec3, v2: Vec3) -> Vec3{
        var maxVec = Vec3(x: 0.0, y: 0.0, z: 0.0)
        
        maxVec.x = max(v0.x, v1.x, v2.x)
        maxVec.y = max(v0.y, v1.y, v2.y)
        maxVec.z = max(v0.z, v1.z, v2.z)
        
        return maxVec
        
    }
    
    
}


