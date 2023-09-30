import Foundation
import Metal
import simd

public struct Vertex{
    public var position: simd_float3
    public var color: simd_float4
    public init(x: Float, y: Float, z: Float, r: Float, g: Float, b: Float, a: Float){
        position = simd_float3(x, y, z)
        color = simd_float4(r, g, b, a)
    }
    static public var vertexDescriptor: MTLVertexDescriptor = {
        let result = MTLVertexDescriptor()
        // POsition
        result.attributes[0].format = .float3
        result.attributes[0].bufferIndex = 0 
        result.attributes[0].offset = 0
        //o Color
        result.attributes[1].format = .float4
        result.attributes[1].bufferIndex = 0
        result.attributes[1].offset = simd_float3.size()
        // layout
        result.layouts[0].stride = Vertex.stride()
        return result
    }()
}
