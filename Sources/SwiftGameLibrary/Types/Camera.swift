import simd
import Metal

public struct Camera{
    var fov: Float = 90
    var aspectRatio: Float = 1
    var near: Float = 1
    var far: Float = 1000
    
    var matrix = Matrix.identity
    // use render function to assign viewMatrix and 
    // projectionMatrix 
}

extension Camera{
    
    public mutating func  projectionMatrix() {
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
        matrix = result
    }
}

