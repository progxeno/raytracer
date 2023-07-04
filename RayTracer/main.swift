//
//  main.swift
//  RayTracingWeekend
//
//  Created by Mario Miosga on 09.12.17.
//  Copyright © 2017 Mario Miosga. All rights reserved.
//

import Foundation

//Image Settings
let Width = 200
let Height = 200
let Samples = 1024
let DepthMax = 10
let imagePath = "~/Desktop/\(Width)x\(Height)_\(Samples)_\(DepthMax).png"

//Camera Settings
let lookFrom = Vec3(x: 278, y: 278, z: -800)
let lookAt = Vec3(x: 278, y: 278, z: 0)
let distToFocus = (lookFrom - lookAt).length
let aperture = 0.0
let vfov = 35.0






func random_in_unit_sphere() -> Vec3 {
    var p = Vec3(x: 0, y: 0, z: 0)
    
    repeat {
        p = 2.0 * Vec3(x: drand48(), y: drand48(), z: drand48()) - Vec3(x: 1, y: 1, z: 1)
    } while p.squared_length >= 1.0
    
    return p
}

func random_in_unit_disk() -> Vec3 {
    var p = Vec3(x: 0, y: 0, z: 0)
    
    repeat {
        p = 2.0 * Vec3(x: drand48(), y: drand48(), z: 0.0) - Vec3(x: 1, y: 1, z: 0)
    } while p.squared_length >= 1.0
    
    return p
}

func color(r: Ray, world: Hitable, depth: Int) -> Vec3 {
    if let rec = world.hit(r: r, 1e-3, Double.infinity) {
        var scattered = Ray(origin: Vec3(x: 0, y: 0, z: 0), direction: Vec3(x: 0, y: 0, z: 0), time: 0.0)
        var attenuantion = Vec3(x: 0, y: 0, z: 0)
        let emitted = rec.material.emitted(u: rec.u, v: rec.v, p: rec.p)
        
        if depth < DepthMax && rec.material.scatter(r_in: r, rec, &attenuantion, &scattered) {
            return emitted + attenuantion * color(r: scattered, world: world, depth: depth + 1)
        }
        else {
            return emitted  // Vec3(x: 0, y: 0, z: 0)
        }
    } else {
        return Vec3(x: 0, y: 0, z: 0)
    }
}

func scene1() -> Hitable {
    let world = HitableList()
    let red = Lambertian(a: ConstantTexture(color: Vec3(x: 0.65, y: 0.05, z: 0.05)))
    let white = Lambertian(a: ConstantTexture(color: Vec3(x: 0.73, y: 0.73, z: 0.73)))
    let green = Lambertian(a: ConstantTexture(color: Vec3(x: 0.12, y: 0.45, z: 0.15)))
    let light = DiffuseLight(emit: ConstantTexture(color: Vec3(x: 2, y: 2, z: 2)))
    
    world.add(h: FlipNormal(ptr: YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 555, material: green)))
    world.add(h: YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 0, material: red))
  //  world.add(h: XZRect(x0: 113, x1: 443, z0: 127, z1: 432, k: 554, material: light))
    world.add(h: FlipNormal(ptr: XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 555, material: light)))
    world.add(h: XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 0, material: white))
    world.add(h: FlipNormal(ptr: XYRect(x0: 0, x1: 555, y0: 0, y1: 555, k: 555, material: white)))
    
//    world.add(h: Triangle(v0_: Vec3(x: 300, y: 200, z: 500), v1_: Vec3(x: 300, y: 20, z: 100), v2_: Vec3(x: 200, y: 20, z: 200), m: red))

    world.add(h: Sphere(c: Vec3(x: 400, y: 340, z: 400), r: 120, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0)))
    world.add(h: Sphere(c: Vec3(x: 250, y: 100, z: 400), r: 100, m: Metal(a: Vec3(x: 0.0, y: 0.5, z: 0.12 ), f: 1.0)))
    world.add(h: Sphere(c: Vec3(x: 450, y: 71, z: 320), r: 70, m: red))
    world.add(h: Sphere(c: Vec3(x: 185, y: 235, z: 140), r: 60, m: Dielectric(index: 1.524)))

    world.add(
        h: Translate(ptr:
            RotateY(p:
                Box(p0: Vec3(x: 0, y: 0, z: 0), p1: Vec3(x: 165, y: 165, z: 165), material: white),
                    angle: -18),
                     offset: Vec3(x: 130, y: 0, z: 65)
        )
    )
    
    return world
}

func scene2() -> Hitable {
    let world = HitableList()
    let red = Lambertian(a: ConstantTexture(color: Vec3(x: 0.65, y: 0.05, z: 0.05)))
    let white = Lambertian(a: ConstantTexture(color: Vec3(x: 0.73, y: 0.73, z: 0.73)))
    let green = Lambertian(a: ConstantTexture(color: Vec3(x: 0.12, y: 0.45, z: 0.15)))
    let light = DiffuseLight(emit: ConstantTexture(color: Vec3(x: 4, y: 4, z: 4)))
    
    world.add(h: FlipNormal(ptr: YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 555, material: green)))
    world.add(h: YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 0, material: red))
    world.add(h: XZRect(x0: 113, x1: 443, z0: 127, z1: 432, k: 554, material: light))
    world.add(h: FlipNormal(ptr: XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 555, material: white)))
    world.add(h: XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 0, material: white))
    world.add(h: FlipNormal(ptr: XYRect(x0: 0, x1: 555, y0: 0, y1: 555, k: 555, material: white)))
    
    world.add(h: Sphere(c: Vec3(x: 420, y: 420, z: 400), r: 70, m: Dielectric(index: 2.4)))
    world.add(h: Sphere(c: Vec3(x: 150, y: 400, z: 400), r: 80, m: Metal(a: Vec3(x: 0.1, y: 0.2, z: 0.5 ), f: 0)))
    world.add(h: Sphere(c: Vec3(x: 260, y: 250, z: 400), r: 70, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0.4)))
    world.add(h: Sphere(c: Vec3(x: 400, y: 61, z: 180), r: 60, m: green))
    world.add(h: Sphere(c: Vec3(x: 300, y: 400, z: 300), r: 20, m: Metal(a: Vec3(x: 0.9, y: 0.1, z: 0.1), f: 0.2)))
    world.add(h: Sphere(c: Vec3(x: 165, y: 100, z: 200), r: 60, m: Dielectric(index: 1.524)))
    world.add(h: Sphere(c: Vec3(x: 415, y: 330, z: 260), r: 20, m: Metal(a: Vec3(x: 0.9, y: 1.0, z: 0.1 ), f: 0.6)))

    
    world.add(
        h: Translate(ptr:
            RotateY(p:
                Box(p0: Vec3(x: 0, y: 0, z: 0), p1: Vec3(x: 165, y: 290, z: 165), material: white),
                    angle: 30),
                     offset: Vec3(x: 265, y: 0, z: 295)
        )
    )
    world.add(
        h: Translate(ptr:
            RotateY(p:
                Box(p0: Vec3(x: 0, y: 0, z: 0), p1: Vec3(x: 40, y: 50, z: 40), material: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0.0)),
                    angle: 60),
                     offset: Vec3(x: 305, y: 290, z: 325)
        )
    )
    
    world.add(
        h: Translate(ptr:
            RotateY(p:
                Box(p0: Vec3(x: 0, y: 0, z: 0), p1: Vec3(x: 20, y: 30, z: 20), material: Metal(a: Vec3(x: 0.1, y: 0.2, z: 0.5 ), f: 0)),
                    angle: 60),
                     offset: Vec3(x: 317.5, y: 340, z: 332.5)
        )
    )
    
    world.add(
        h: Translate(ptr:
            RotateY(p:
                Box(p0: Vec3(x: 0, y: 0, z: 0), p1: Vec3(x: 80, y: 200, z: 80), material: Metal(a: Vec3(x: 0.3, y: 0.6, z: 0.7 ), f: 0.0)),
                    angle: -40),
                     offset: Vec3(x: 130, y: 0, z: 295)
        )
    )
    
    return world
}

func scene3() -> Hitable {
    let world = HitableList()
    let red = Lambertian(a: ConstantTexture(color: Vec3(x: 0.65, y: 0.05, z: 0.05)))
    let white = Lambertian(a: ConstantTexture(color: Vec3(x: 0.73, y: 0.73, z: 0.73)))
    let green = Lambertian(a: ConstantTexture(color: Vec3(x: 0.12, y: 0.45, z: 0.15)))
    let light = DiffuseLight(emit: ConstantTexture(color: Vec3(x: 4, y: 4, z: 4)))
    
    world.add(h: FlipNormal(ptr: YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 555, material: green)))
    world.add(h: YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 0, material: red))
    world.add(h: XZRect(x0: 113, x1: 443, z0: 127, z1: 432, k: 554, material: light))
    world.add(h: FlipNormal(ptr: XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 555, material: white)))
    world.add(h: XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 0, material: white))
    world.add(h: FlipNormal(ptr: XYRect(x0: 0, x1: 555, y0: 0, y1: 555, k: 555, material: white)))
    
    world.add(h: Sphere(c: Vec3(x: 400, y: 340, z: 400), r: 120, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0)))
    world.add(h: Sphere(c: Vec3(x: 278, y: 240, z: 50), r: 40, m: Dielectric(index: 2.4)))
    world.add(h: Sphere(c: Vec3(x: 400, y: 180, z: 80), r: 50, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 1.0)))
    world.add(h: Sphere(c: Vec3(x: 200, y: 400, z: 400), r: 80, m: Metal(a: Vec3(x: 0.1, y: 0.2, z: 0.5 ), f: 0)))
    world.add(h: Sphere(c: Vec3(x: 165, y: 130, z: 200), r: 80, m: Dielectric(index: 1.524)))
    
    world.add(
        h: Translate(ptr:
            RotateY(p:
                Box(p0: Vec3(x: 0, y: 0, z: 0), p1: Vec3(x: 165, y: 120, z: 165), material: white),
                    angle: 15),
                  offset: Vec3(x: 265, y: 0, z: 295)
        )
    )
    
    return world
}

func scene4() -> Hitable {
    let world = HitableList()
    let red = Lambertian(a: ConstantTexture(color: Vec3(x: 0.65, y: 0.05, z: 0.05)))
    let white = Lambertian(a: ConstantTexture(color: Vec3(x: 0.73, y: 0.73, z: 0.73)))
    let green = Lambertian(a: ConstantTexture(color: Vec3(x: 0.12, y: 0.45, z: 0.15)))
    let light = DiffuseLight(emit: ConstantTexture(color: Vec3(x: 4, y: 4, z: 4)))
    
    world.add(h: FlipNormal(ptr:    YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 555, material: green)))
    world.add(h:                    YZRect(y0: 0, y1: 555, z0: 0, z1: 555, k: 0, material: red))
    world.add(h: FlipNormal(ptr:    XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 555, material: white)))
    world.add(h:                    XZRect(x0: 0, x1: 555, z0: 0, z1: 555, k: 0, material: white))
    world.add(h: FlipNormal(ptr:    XYRect(x0: 0, x1: 555, y0: 0, y1: 555, k: 555, material: white)))
    world.add(h:                    XYRect(x0: -10000, x1: 10000, y0: -10000, y1: 10000, k: -801, material: light))

    world.add(h: XZRect(x0: 113, x1: 443, z0: 127, z1: 432, k: 554, material: light))

    
    world.add(h: Sphere(c: Vec3(x: 275, y: 101, z: 275), r: 100, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0.0)))
    world.add(h: Sphere(c: Vec3(x: 275, y: 250, z: 275), r: 70, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0.0)))
    world.add(h: Sphere(c: Vec3(x: 275, y: 355, z: 275), r: 40, m: Metal(a: Vec3(x: 0.8, y: 0.8, z: 0.9 ), f: 0.0)))

    return world
}


func toneMap(color: PixelRGB32) -> PixelRGBU8 {
    let gamma: Float = 2.0
    let invGamma = 1.0/gamma
    return PixelRGBU8(r: powf(color.r, invGamma), g: powf(color.g, invGamma), b: powf(color.b, invGamma))
}

// main



let cam = Camera(
    lookFrom: lookFrom,
    lookAt: lookAt,
    vup: Vec3(x: 0, y: 1, z: 0),
    vfov: vfov,
    aspect: Double(Width) / Double(Height),
    aperture: aperture,
    focus_dist: distToFocus,
    t0: 0.0,
    t1: 1.0
)

let scene = scene4()
//let scene = scene2()



print("SwiftRay")
let url = URL(fileURLWithPath: NSString(string: imagePath).expandingTildeInPath)
print("Generating image (\(Width) by \(Height)) with \(Samples) Samples and a Depth of \(DepthMax)")
print("Saving Image at \(imagePath)")
let startDate = Date()
print("Rendering Started: \(startDate)")

let bitmap = Bitmap(width: Width, height: Height)
let accumulator = ImageAccumulator()

func save(image: Image) {
    let accumulatedImage =  accumulator.accumulate(image: image)
    bitmap.generate { (x, y) -> PixelRGBU8 in
        return toneMap(color: accumulatedImage.pixelAt(x: x, y: y))
    }
    
    if !bitmap.writePng(url: url) {
        print("Error saving image at \(imagePath).")
    }
}
func printProgress(sampleIndex: Int, sampleCount:Int) {
    let progress = (Float(sampleIndex+1)/Float(sampleCount))*100.0
    print("Sample \(sampleIndex+1)/\(sampleCount) (\(progress) %)")
}


let raytracingQueue = OperationQueue()
raytracingQueue.name = "com.ceroce.SwiftRay Raytracing"
raytracingQueue.maxConcurrentOperationCount = 8 // Parallel queue

let imageSavingQueue = OperationQueue()
imageSavingQueue.name = "com.ceroce.SwiftRay Image Saving"
imageSavingQueue.maxConcurrentOperationCount = 2    // Serial queue


var samplesRendered = 0;
for _ in 0..<Samples {
    raytracingQueue.addOperation {
        let image = Image(width: Width, height: Height)
        image.generate { (x, y) -> PixelRGB32 in
            let s = (Double(x)+random01()) / Double(Width)
            let t = 1.0 - (Double(y)+random01()) / Double(Height)
            let ray = cam.get_ray(s: s, t)
            let col = color(r: ray, world: scene, depth: 0)
            
            return PixelRGB32(r: Float32(col.x), g: Float32(col.y), b: Float32(col.z))
        }
        
        imageSavingQueue.addOperation {
            save(image: image)
            printProgress(sampleIndex: samplesRendered, sampleCount: Samples)
            samplesRendered += 1
        }
    }
    
}


while samplesRendered == 0 || (imageSavingQueue.operationCount > 0) || (raytracingQueue.operationCount > 0) {
    // Wait
    
}

let renderingDuration = Date().timeIntervalSince(startDate)
print("Image rendered in \(renderingDuration) s.")
