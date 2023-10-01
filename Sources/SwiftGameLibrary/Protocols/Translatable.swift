import simd

public protocol Translatable: AnyObject{
    var position: simd_float3 { get set }
    
}

extension Translatable{
    public func matrixTranslationModel(from: matrix_float4x4 = matrix_identity_float4x4)-> matrix_float4x4{
        var result = matrix_identity_float4x4
        result.columns = (
            simd_float4(1, 0, 0, 0),
            simd_float4(0, 1, 0, 0),
            simd_float4(0, 0, 1, 0),
            simd_float4(
                position.x, 
                position.y, 
                position.z, 
                1)
        )
        return matrix_multiply(from, result)
    }
    
    public func matrixTranslationView(from: matrix_float4x4 = matrix_identity_float4x4)-> matrix_float4x4{
        var result = matrix_identity_float4x4
        result.columns = (
            simd_float4(1, 0, 0, 0),
            simd_float4(0, 1, 0, 0),
            simd_float4(0, 0, 1, 0),
            simd_float4(
                -position.x, 
                -position.y, 
                -position.z, 
                1)
        )
        return matrix_multiply(from, result)
    }
    
    
    public func moveX(by delta: Float){
        position.x += delta
    }
    public func moveY(by delta: Float){
        position.y += delta
    }
    public func moveZ(by delta: Float){
        position.z += delta
    }
}
