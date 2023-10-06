import simd
import Metal

public struct Camerae{
    var fov: Float 
    var aspectRatio: Float
    var near: Float
    var far: Float 
    
    
    // use render function to assign viewMatrix and 
    // projectionMatrix 
}

extension Camera{
    
    public func  projectionMatrix() -> Matrix {
        var result = matrix_identity_float4x4
        let t: Float = tan(fov / 2)
        result.columns = (
            simd_float4(1 / (aspectRatio * t),
                        0,
                        0,
                        0),
            simd_float4(0,
                        1 / t,
                        0,
                        0),
            simd_float4(0,
                        0,
                        -((far + near) / (far - near)),
                        -1),
            simd_float4(0,
                        0,
                        -((2 * far * near) / (far - near)),
                        0)
        )
        return result
        
    }
}

