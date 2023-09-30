import simd

public protocol Rotatable: AnyObject{
    var rotation: simd_float3 { get set }
}


extension Rotatable{

    public func rotateXModel(from: matrix_float4x4 = matrix_identity_float4x4)-> matrix_float4x4{
        var result = matrix_identity_float4x4
        let x: Float = 1
        let y: Float = 0
        let z: Float = 0
        
        let c: Float = cos(rotation.x)
        let s: Float = sin(rotation.x)
        
        let mc: Float = (1 - c)   
        
        result.columns = (
            simd_float4(x * x * mc + c,
                        x * y * mc + z * s,
                        x * z * mc - y * s,
                        0),
            simd_float4(y * x * mc - z * s,
                        y * y * mc + c,
                        y * z * mc + x * s,
                        0),
            simd_float4(z * x * mc + y * s,
                        z * y * mc - x * s,
                        z * z * mc + c,
                        0),
            simd_float4(0,0,0,1)
        )
        return matrix_multiply(from, result)
    }
    
    public func rotateYModel(from: matrix_float4x4 = matrix_identity_float4x4)-> matrix_float4x4{
        var result = matrix_identity_float4x4
        let x: Float = 0
        let y: Float = 1
        let z: Float = 0
        
        let c: Float = cos(rotation.y)
        let s: Float = sin(rotation.y)
        
        let mc: Float = (1 - c)   
        
        result.columns = (
            simd_float4(x * x * mc + c,
                        x * y * mc + z * s,
                        x * z * mc - y * s,
                        0),
            simd_float4(y * x * mc - z * s,
                        y * y * mc + c,
                        y * z * mc + x * s,
                        0),
            simd_float4(z * x * mc + y * s,
                        z * y * mc - x * s,
                        z * z * mc + c,
                        0),
            simd_float4(0,0,0,1)
        )
        return matrix_multiply(from, result)
    }
    
    public func rotateZModel(from: matrix_float4x4 = matrix_identity_float4x4)-> matrix_float4x4{
        var result = matrix_identity_float4x4
        let x: Float = 0
        let y: Float = 0
        let z: Float = 1
        
        let c: Float = cos(rotation.z)
        let s: Float = sin(rotation.z)
        
        let mc: Float = (1 - c)   
        
        result.columns = (
            simd_float4(x * x * mc + c,
                        x * y * mc + z * s,
                        x * z * mc - y * s,
                        0),
            simd_float4(y * x * mc - z * s,
                        y * y * mc + c,
                        y * z * mc + x * s,
                        0),
            simd_float4(z * x * mc + y * s,
                        z * y * mc - x * s,
                        z * z * mc + c,
                        0),
            simd_float4(0,0,0,1)
        )
        return matrix_multiply(from, result)
    }
}

