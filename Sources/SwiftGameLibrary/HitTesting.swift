import Foundation
import simd

extension GameScene{
    public func performHitTest(x: Float, y: Float)-> HitResult?{
        // From screen space to clip space
        let clipX = (2 * x) / camera.viewport.width - 1
        let clipY = 1 - (2 * y) / camera.viewport.height
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
            print(node.position.z)
            if let result = node.isHitTested(ray: ray){ 
                results.append(result)}
        }
        results.sort(by:  {$0.parameter < $1.parameter})
      //  if let child: GameNode = findTopLevel(of: results[0].node){
      //         results[0].topLevelNode = child
      //  }
		return results.first
    }
    
}

extension GameNode{
    public func hitTest() { }
    public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)-> HitResult?{
        var result: HitResult? = nil
        let box = BoundBox(worldPos: modelMatrix.xyz, lengthOnXAxis: parentScale.x * scale.x, lengthOnYAxis: parentScale.y * scale.y, lengthOnZAxis: parentScale.z * scale.z)
        if let parm = box.intersect(ray){
            result = HitResult(node: self, ray: ray, parameter: parm)
        }
        return result
    }
}
