import Foundation
import simd

extension GameScene{
	public func performHitTest(x: Float, y: Float, boundX: Float, boundY: Float)-> HitResult?{
        let ray = calculateHitTestRay(x: x, y: y, boundX: boundX, boundY: boundY)
        var results: [HitResult] = []
        children.forEach(){ key, node in
			if node.id != camera.id{
				if let result = node.isHitTested(ray: ray){
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
// only a visible Mesh will actually pass a hit test. But a gamenode will pass if it has children mesh that pass
extension MeshNode{
	override public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)->HitResult?{
		//let newScale = parentScale * scale
		let box = Mesh.getBoundingBox(center: position, scaledBy: parentScale * scale)
		var result: HitResult? = nil
		if let hit = box.intersect(ray: ray){
			return HitResult(node: self
						ray: ray,
						parameter: hit)
		} else {
			return hitTestAllChildren(ray: ray, parentScale: parentScale)
		}
	}
}
extension GameNode{
	public func hitTestAllChildren(ray: Ray, parentScale: SIMD3<Float> = .one)->HitResult?{
		for key in children.keys{
			if let hit = if let hit = children[key]!.isHitTested(ray: ray, parentScale: parentScale * scale){
					var result = hit
					result.changeTopLevel(to: self)
					return result
			}
		}
		return nil
	}
}
extension GameNode{
    //public func hitTest() { }
    public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)-> HitResult?{
        hitTestAllChildren(ray: ray, parentScale: scale)
    }
}
