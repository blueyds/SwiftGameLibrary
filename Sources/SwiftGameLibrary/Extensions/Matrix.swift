import simd

public typealias Matrix = simd_float4x4

extension Matrix{
    public static var identity: Matrix { 
        matrix_identity_float4x4
    }
    public mutating func translateModel(_ v3: float3){
        var result = Matrix.identity
        result.columns = (
            simd_float4(1,      0,      0,      0),
            simd_float4(0,      1,      0,      0),
            simd_float4(0,      0,      1,      0),
            simd_float4(v3.x,   v3.y,   v3.z,   1)
        )
        self = matrix_multiply(self, result)
    }
    public mutating func translateView(_ position: simd_float3){
        translateModel(-position)
    }
    
    public mutating func scale(_ v3: float3){
        var result = matrix.identity
        result.columns = (
            simd_float4(v3.x, 0, 0, 0),
            simd_float4(0, v3.y, 0, 0),
            simd_float4(0, 0, v3.z, 0),
            simd_float4(0, 0, 0, 1)
        )
        self = matrix_multiply(self, result)
    }
    public mutating func rotate(_ v3: float3){
        rotate(v3.x, onX: true)
        rotate(v3.y, onY: true)
        rotate(v3.z, onZ: true)
    }
    
    private mutating func rotate(_ amount: Float, onX: Bool = false, onY: Bool = false, onZ: Bool = false){
        var result = Matrix.identity
        var x: Float = 0
        var y: Float = 0
        var z: Float = 0
        
        if onX { x = 1}
        else if onY { y = 1}
        else if onZ { z = 1 }
        else { return }
        
        let c: Float = cos(amount)
        let s: Float = sin(amount)
        
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
        self = matrix_multiply(self, result)
    }
    
    
}