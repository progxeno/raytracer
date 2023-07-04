//
//  HitRecord.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class HitRecord {
    var t = 0.0
    var p = Vec3(x: 0, y: 0, z: 0)
    var u = 0.0
    var v = 0.0
    var normal = Vec3(x: 0, y: 0, z: 0)
    var material: Material = Metal(a: Vec3(x: 0, y: 0, z: 0), f: 0)
    
    init(t: Double, p: Vec3, u: Double, v: Double, normal: Vec3, material: Material) {
        self.t = t
        self.p = p
        self.u = u
        self.v = v
        self.normal = normal
        self.material = material
    }
}
