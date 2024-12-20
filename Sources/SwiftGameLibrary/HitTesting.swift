import Foundation
import simd
import SwiftGameTypes

extension GameScene{
	public func performHitTest(x: Float, y: Float, boundX: Float, boundY: Float)-> HitResult?{
        let ray = calculateHitTestRay(x: x, y: y, boundX: boundX, boundY: boundY)
        var results: [HitResult] = []
		for child in children {
			if child.id != camera.id{
				if let result = child.isHitTested(ray: ray){
					results.append(result)
				}
			}
		}
		results.sort(by:  {$0.parameter < $1.parameter})
		
		return results.first
    }
	
	public func calculateHitTestRay(x: Float, y: Float, boundX: Float, boundY: Float)->Ray{
		// From screen space to clip space
		let clipX = (2.0 * x / boundX) - 1.0
		let clipY = (2.0 * -y / boundY) + 1.0
		let clipCoords = SIMD4( clipX, clipY,0 ,1)
		//let camera = getCamera()
		// from clip space to view space
		let inverseProjectionMatrix = camera.getProjectionMatrix().inverse
		var eyeRayDir = inverseProjectionMatrix * clipCoords // ray that will intersect with our objects
		eyeRayDir.z = -1 // ray should be pointing into the scene
		eyeRayDir.w = 0 // allow it to transform as a vector
		
		// from view space to world space 
		let inverseViewMatrix = camera.getViewMatrix().inverse
		let worldRayDir = normalize((inverseViewMatrix * eyeRayDir).xyz)
		
		// computing picking ray origin
		let eyeRayOrigin = SIMD4<Float>(0, 0, 0, 1)
		let worldRayOrigin = (inverseViewMatrix * eyeRayOrigin).xyz
		
		// calculate hit test ray
		return Ray(origin: worldRayOrigin, direction: worldRayDir)
	}
}

