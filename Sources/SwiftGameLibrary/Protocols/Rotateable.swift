import simd

public protocol Rotatable: AnyObject{
    var rotation: float3 { get set }
}
extension Rotatable{
	public func rotateX(by angle: Float){
        rotation.x += angle.fromDegrees   
    }
    public func rotateY(by angle: Float){
        rotation.y += angle.fromDegrees
    }
    public func rotateZ(by angle: Float){
        rotation.z += angle.fromDegrees
	 }
}


    