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
extension SIMD2<Float>: sizeable{}
extension SIMD3<Float>: sizeable{}
extension SIMD4<Float>: sizeable{}
extension Vertex: sizeable {}
extension Matrix: sizeable {}
extension Int32: sizeable {}
extension Int16: sizeable {}
extension UInt32: sizeable {}
extension UInt16: sizeable {}
extension Float: sizeable {}
