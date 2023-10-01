import simd

public protocol Scaleable: AnyObject {
    var scale: simd_float3 { get set }
}

extension Scaleable {
    
    public func matrixScaleModel(from: matrix_float4x4 = matrix_identity_float4x4)-> matrix_float4x4{
        var result: matrix_float4x4 = matrix_identity_float4x4
        result.columns = (
            simd_float4(scale.x, 0, 0, 0),
            simd_float4(0, scale.y, 0, 0),
            simd_float4(0, 0, scale.z, 0),
            simd_float4(0, 0, 0, 1)
        )
        return matrix_multiply(from, result)
    }
    
    
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

