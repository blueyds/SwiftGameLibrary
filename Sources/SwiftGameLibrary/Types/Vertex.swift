import Foundation
import Metal
import simd

public struct Vertex{
    public var position: float3
    public var color: float4
    public var normals: float3
    public var texCoord: float2
    public init(x: Float, y: Float, z: Float, r: Float, g: Float, b: Float, a: Float){
        position = float3(x, y, z)
        color = float4(r, g, b, a)
        normals = float3.Zero
        texCoor = float2.Zero
    }
    public init(_ pos: float3, _ color: Color){
        self.position = pos
        self.color = color.vector
        normals = float3.Zero
        texCoor = float2.Zero
    }
    static public var vertexDescriptor: MTLVertexDescriptor = {
        let result = MTLVertexDescriptor()
        // POsition
        result.attributes[0].format = .float3
        result.attributes[0].bufferIndex = 0 
        result.attributes[0].offset = 0
        var offset = result.attributes[0].offset + float3.size()
        //o Color
        result.attributes[1].format = .float4
        result.attributes[1].bufferIndex = 0
        result.attributes[1].offset = offset
        offset += float4.size()
        // normals 
        result.attributes[2].format = .float3
        result.attributes[2].bufferIndex = 0
        result.attributes[2].offset = offset
        offset += float3.size()
        // texCoord
        result.attributes[3].format = .float2
        result.attributes[3].bufferIndex = 0
        result.attributes[3].offset = offset
        // layout
        result.layouts[0].stride = Vertex.stride()
        return result
    }()
}
