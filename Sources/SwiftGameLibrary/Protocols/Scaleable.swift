import simd

public protocol Scaleable: AnyObject {
    var scale: float3 { get set }
}

extension Scaleable {
    
    
    public func scaleX(by delta: Float){
        scale.x *= delta
    }
    public func scaleY(by delta: Float){
        scale.y *= delta
    }
    public func scaleZ(by delta: Float){
        scale.z *= delta
    }
    public func scaleAll(by delta: Float){
        scaleX(by: delta)
        scaleY(by: delta)
        scaleZ(by: delta)
    }
}

