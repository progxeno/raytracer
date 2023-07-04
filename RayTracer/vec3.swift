//
//  Vec3.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

struct Vec3 : CustomStringConvertible {
    var x: Double
    var y: Double
    var z: Double
    
    var r: Double {
        get {
            return x
        }
        set {
            x = newValue
        }
    }
    
    var g: Double {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    var b: Double {
        get {
            return z
        }
        set {
            z = newValue
        }
    }
    
    subscript(index: Int) -> Double {
        get {
            switch (index) {
            case 0:
                return x
            case 1:
                return y
            case 2:
                return z
            default:
                assert(false, "Index out of range")
            }
            return Double.nan
        }
        set(newValue) {
            switch (index) {
            case 0:
                x = newValue
            case 1:
                y = newValue
            case 2:
                z = newValue
            default:
                assert(false, "Index out of range")
            }
        }
    }
    
    var description: String {
        return "\(x) \(y) \(z)"
    }
    
    var length: Double {
        return sqrt(x*x + y*y + z*z)
    }
    
    // aka. Magnitude
    var squared_length: Double {
        return x*x + y*y + z*z
    }
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }

    func dot(v2: Vec3) -> Double {
        return x * v2.x + y * v2.y + z * v2.z
    }
    
    func cross(v2: Vec3) -> Vec3 {
        let rx = y*v2.z - z*v2.y
        let ry = -(x*v2.z - z*v2.x)
        let rz = x * v2.y - y * v2.x
        
        return Vec3(x: rx, y: ry, z: rz)
    }
    
    func unit_vector() -> Vec3 {
        let k = 1.0 / sqrt(x*x + y*y + z*z)
        
        return Vec3(x: x * k, y: y * k, z: z * k)
    }
    
    func reflect(v2: Vec3) -> Vec3 {
        return self - 2 * self.dot(v2: v2) * v2
    }
}

// prefixes

prefix func - (v: Vec3) -> Vec3 {
    return Vec3(x: -v.x, y: -v.y, z: -v.z)
}

// binaries

func + (v1: Vec3, v2: Vec3) -> Vec3 {
    return Vec3(x: v1.x + v2.x, y: v1.y + v2.y, z: v1.z + v2.z)
}

func - (v1: Vec3, v2: Vec3) -> Vec3 {
    return Vec3(x: v1.x - v2.x, y: v1.y - v2.y, z: v1.z - v2.z)
}

func * (v1: Vec3, v2: Vec3) -> Vec3 {
    return Vec3(x: v1.x * v2.x, y: v1.y * v2.y, z: v1.z * v2.z)
}

func / (v1: Vec3, v2: Vec3) -> Vec3 {
    return Vec3(x: v1.x / v2.x, y: v1.y / v2.y, z: v1.z / v2.z)
}

func * (v: Vec3, s: Double) -> Vec3 {
    return Vec3(x: v.x * s, y: v.y * s, z: v.z * s)
}

func * (s: Double, v: Vec3) -> Vec3 {
    return Vec3(x: v.x * s, y: v.y * s, z: v.z * s)
}

func / (v: Vec3, s: Double) -> Vec3 {
    return Vec3(x: v.x / s, y: v.y / s, z: v.z / s)
}

func squaredLength(_ v: Vec3) -> Double {
    return v.x*v.x + v.y*v.y + v.z*v.z
}

func length(_ v: Vec3) -> Double {
    return Double(sqrtf(Float(squaredLength(v))))
}

func normalize(_ v: Vec3) -> Vec3 {
    return v / length(v)
}

func mix(_ u: Vec3, _ v: Vec3, _ alpha: Double) -> Vec3 {
    return (1.0-alpha)*u + alpha*v
}
