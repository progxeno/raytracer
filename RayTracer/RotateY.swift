//
//  RotateY.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class RotateY : Hitable {
    let ptr: Hitable
    let sinTheta: Double
    let cosTheta: Double
    let bbox: AABB?
    
    init(p: Hitable, angle: Double) {
        let radians = (Double.pi / 180.0) * angle
        
        ptr = p
        sinTheta = sin(radians)
        cosTheta = cos(radians)
        
        if let bb = p.boundingBox(t0: 0, 1) {
            var min = Vec3(x: Double.greatestFiniteMagnitude,
                           y: Double.greatestFiniteMagnitude,
                           z: Double.greatestFiniteMagnitude)
            var max = Vec3(x: -Double.greatestFiniteMagnitude,
                           y: -Double.greatestFiniteMagnitude,
                           z: -Double.greatestFiniteMagnitude)
            
            for i in stride(from: 0.0, to: 2.0, by: 1.0) {
                for j in stride(from: 0.0, to: 2.0, by: 1.0) {
                    for k in stride(from: 0.0, to: 2.0, by: 1.0) {
                        let x = i * bb.max.x + (1.0 - i) * bb.min.x
                        let y = j * bb.max.y + (1.0 - j) * bb.min.y
                        let z = k * bb.max.z + (1.0 - k) * bb.min.z
                        let newX = cosTheta * x + sinTheta * z
                        let newZ = -sinTheta * x + cosTheta * z
                        let tester = Vec3(x: newX, y: y, z: newZ)
                        
                        for c in 0..<3 {
                            if tester[c] > max[c] {
                                max[c] = tester[c]
                            }
                            if tester[c] < min[c] {
                                min[c] = tester[c]
                            }
                        }
                    }
                }
            }
            
            bbox = AABB(min: min, max: max)
        }
        else {
            bbox = nil
        }
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        var origin = r.origin
        var direction = r.direction
        
        origin[0] = cosTheta * r.origin[0] - sinTheta * r.origin[2]
        origin[2] = sinTheta * r.origin[0] + cosTheta * r.origin[2]
        direction[0] = cosTheta * r.direction[0] - sinTheta * r.direction[2]
        direction[2] = sinTheta * r.direction[0] + cosTheta * r.direction[2]
        
        let rotatedR = Ray(origin: origin, direction: direction, time: r.time)
        
        if let rec = ptr.hit(r: rotatedR, t_min, t_max) {
            var p = rec.p
            var normal = rec.normal
            
            p[0] = cosTheta * rec.p[0] + sinTheta * rec.p[2]
            p[2] = -sinTheta * rec.p[0] + cosTheta * rec.p[2]
            normal[0] = cosTheta * rec.normal[0] + sinTheta * rec.normal[2]
            normal[2] = -sinTheta * rec.normal[0] + cosTheta * rec.normal[2]
            
            rec.p = p
            rec.normal = normal
            
            return rec
        }
        
        return nil
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return bbox
    }
}
