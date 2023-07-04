//
//  DiffuseLight.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

class DiffuseLight : Material {
    let emit: Texture
    
    init(emit: Texture) {
        self.emit = emit
    }
    
    func scatter(r_in: Ray, _ rec: HitRecord, _ attentuation: inout Vec3, _ scattered: inout Ray) -> Bool {
        return false
    }
    
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3 {
        return emit.value(u: u, v, p)
    }
}
