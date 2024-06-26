import Foundation
import simd

extension GameScene{
	public func performHitTest(x: Float, y: Float, boundX: Float, boundY: Float)-> HitResult?{
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
        let ray = Ray(origin: worldRayOrigin, direction: worldRayDir)
        var results: [HitResult] = []
        children.sorted(by: {$0.value.position.z < $1.value.position.z}).forEach(){ key, node in
            //print(node.position.z)
			if node.id != camera.id{
				if let result = node.isHitTested(ray: ray){
					results.append(result)
				}
			}
        }
        results.sort(by:  {$0.parameter < $1.parameter})
      //  if let child: GameNode = findTopLevel(of: results[0].node){
      //         results[0].topLevelNode = child
      //  }
		results.forEach(){
			print("name \($0.node.name) position \($0.node.position) parm \($0.parameter)")
		}
		return results.first
    }
    
}

extension GameNode{
    //public func hitTest() { }
    public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)-> HitResult?{
        var result: HitResult? = nil
		let newScale = SIMD3<Float>(parentScale.x * scale.x, parentScale.y * scale.y, parentScale.z * scale.z)
        let box = AxisAlignedBoundingBox(worldPos: modelMatrix.xyz, lengthOnXAxis: newScale.x, lengthOnYAxis: newScale.y, lengthOnZAxis: newScale.z)
        if let parm = box.intersect(ray){
            result = HitResult(node: self, ray: ray, parameter: parm)
        } else{
			for key in children.keys {
				if let hit = children[key]!.isHitTested(ray: ray, parentScale: newScale){
					return hit
				}
			}
		}
        return result
    }
}
