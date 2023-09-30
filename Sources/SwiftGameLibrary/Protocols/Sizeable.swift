import simd

public protocol sizeable{
    static func size(of count : Int) -> Int
    static func stride(of count: Int) -> Int
} 

extension sizeable{
    public static func size() -> Int {
        MemoryLayout<Self>.size
    }
    
    public static func stride() -> Int{
        MemoryLayout<Self>.stride
    }
    
    public static func size(of count: Int) -> Int{
        size() * count
    }
    
    public static func stride(of count: Int) -> Int{
        stride() * count
    }
}
extension simd_float3: sizeable{}
extension simd_float4: sizeable{}
extension Vertex: sizeable {}
extension simd_float4x4: sizeable {}

