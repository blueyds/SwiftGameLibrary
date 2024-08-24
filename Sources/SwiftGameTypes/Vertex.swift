import Foundation
import Metal
import simd

public struct Vertex{
	public var position: SIMD3<Float>
	public var color: SIMD4<Float>
	public var normals: SIMD3<Float> = .zero
	public var texCoord: SIMD2<Float> = .zero
	
	public init(_ x: Float, _ y: Float, _ z: Float, _ r: Float, _ g: Float, _ b: Float,_ a: Float,_ u: Float = 0,_ v: Float = 0){
		self.init(pos: SIMD3<Float>(x, y, z), color:  SIMD4<Float>(r, g, b, a), normals: .zero, texCoord: SIMD2<Float>(u, v))
	}
	

	public init(_ x: Float,_ y: Float, _ z: Float){
		self.init(pos: SIMD3<Float>(x, y, z), color: SIMD4<Float>(0,0,0,1), normals: .zero, texCoord: .zero)
	}
	
	public init(_ pos: SIMD3<Float>, _ color: Color, _ normals: SIMD3<Float> = .zero, texCoord: SIMD2<Float> = .zero){
		self.init(pos: pos, color: color.rgba, normals: normals, texCoord: texCoord)
		
	}
	
	public init( pos: SIMD3<Float>, color: SIMD4<Float>,  normals: SIMD3<Float>,  texCoord: SIMD2<Float>){
		self.position = pos
		self.color = color
		self.normals = normals
		self.texCoord = texCoord
	}

	static public var vertexDescriptor: MTLVertexDescriptor = {
		let result = MTLVertexDescriptor()
		// POsition
		result.attributes[0].format = .float3
		result.attributes[0].bufferIndex = 0 
		result.attributes[0].offset = 0
		var offset = result.attributes[0].offset + SIMD3<Float>.size()
		//o Color
		result.attributes[1].format = .float4
		result.attributes[1].bufferIndex = 0
		result.attributes[1].offset = offset
		offset += SIMD4<Float>.size()
		// normals 
		result.attributes[2].format = .float3
		result.attributes[2].bufferIndex = 0
		result.attributes[2].offset = offset
		offset += SIMD3<Float>.size()
		// texCoord
		result.attributes[3].format = .float2
		result.attributes[3].bufferIndex = 0
		result.attributes[3].offset = offset
		// layout
		result.layouts[0].stride = Vertex.stride()
		return result
	}()
}

extension Vertex: Comparable{
	public static func < (lhs: Vertex, rhs: Vertex) -> Bool {
		lhs.position.x < rhs.position.x &&
		lhs.position.y < rhs.position.y &&
		lhs.position.z < rhs.position.z
	}
	

}
