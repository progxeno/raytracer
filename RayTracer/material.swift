//
//  Material.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

protocol Material {
    func scatter(r_in: Ray, _ rec: HitRecord, _ attentuation: inout Vec3, _ scattered: inout Ray) -> Bool
    func emitted(u: Double, v: Double, p: Vec3) -> Vec3
}
