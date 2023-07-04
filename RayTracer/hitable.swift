//
//  Hitable.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

protocol Hitable {
    func hit(r: Ray, _ t_min: Double, _ t_max: Double) -> HitRecord?
    func boundingBox(t0: Double, _ t1: Double) -> AABB?
}
