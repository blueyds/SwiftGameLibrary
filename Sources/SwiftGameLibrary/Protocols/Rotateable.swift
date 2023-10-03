import simd

public protocol Rotatable: AnyObject{
    var rotation: simd_float3 { get set }
}
extension Rotatable{
	public func rotateXby(degrees angle: Float){
        rotation.x += angle.fromDegrees   
    }
    public func rotateYby(degrees angle: Float){
        rotation.y += angle.fromDegrees
    }
    public func rotateZby(degrees angle: Float){
        rotation.z += angle.fromDegrees
	 }
}


