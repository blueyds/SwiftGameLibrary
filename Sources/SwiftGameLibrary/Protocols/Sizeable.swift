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
extension float3: sizeable{}
extension float4: sizeable{}
extension Vertex: sizeable {}
extension matrix: sizeable {}

