import simd

public struct Transforms{
    public var position = float3.Zero
    public var rotation = float3.Zero
    public var scale = float3.One
    public var matrix = Matrix.identity
}