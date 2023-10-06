import simd

public struct Transforms{
    public var position = float3.Zero
    public var rotation = float3.Zero
    public var scale = float3.One
    public var matrix = Matrix.identity
    public init(){}
    public init(position: float3, rotation: float3, scale: float3){
        self.position = position
        self.rotation = rotation
        self.scale = scale
    }
}