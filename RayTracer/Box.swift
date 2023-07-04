//
//  Box.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 10.01.18.
//  Copyright © 2018 Mario Miosga. All rights reserved.
//

import Foundation

class Box : Hitable {
    let pmin: Vec3
    let pmax: Vec3
    let sides: HitableList
    
    init(p0: Vec3, p1: Vec3, material: Material) {
        pmin = p0
        pmax = p1
        
        sides = HitableList()
        sides.add(h: XYRect(x0: p0.x, x1: p1.x, y0: p0.y, y1: p1.y, k: p1.z, material: material))
        sides.add(h: FlipNormal(ptr: XYRect(x0: p0.x, x1: p1.x, y0: p0.y, y1: p1.y, k: p0.z, material: material)))
        sides.add(h: XZRect(x0: p0.x, x1: p1.x, z0: p0.z, z1: p1.z, k: p1.y, material: material))
        sides.add(h: FlipNormal(ptr: XZRect(x0: p0.x, x1: p1.x, z0: p0.z, z1: p1.z, k: p0.y, material: material)))
        sides.add(h: YZRect(y0: p0.y, y1: p1.y, z0: p0.z, z1: p1.z, k: p1.x, material: material))
        sides.add(h: FlipNormal(ptr: YZRect(y0: p0.y, y1: p1.y, z0: p0.x, z1: p1.z, k: p0.x, material: material)))
    }
    
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord? {
        return sides.hit(r: r, t_min, t_max)
    }
    
    func boundingBox(t0: Double, _ t1: Double) -> AABB? {
        return AABB(min: pmin, max: pmax)
    }
}

