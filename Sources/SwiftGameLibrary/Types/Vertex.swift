import Foundation
import Metal
import simd

public struct Vertex{
	public var position: SIMD3<Float>
	public var color: SIMD4<Float>
	public var normals: SIMD3<Float> = .zero
	public var texCoord: SIMD2<Float> = .zero
	
	public convenience init(x: Float, y: Float, z: Float, r: Float, g: Float, b: Float, a: Float, u: Float = 0, v: Float = 0){
		self.init(SIMD3<Float>(x, y, z), SIMD4<Float>(r, g, b, a), SIMD2<Float>(u, v)
	}
	

	public convenience init(x: Float, y: Float, z: Float){
		self.init(SIMD3<Float>(x, y, z), SIMD4<Float>(0,0,0,1), .zero, .zero)
	}
	
	public convenience init(_ pos: SIMD3<Float>, _ color: Color, _ normals: SIMD3<Float> = .zero, texCoord: SIMD2<Float> = .zero){
		self.init(pos, color.rgba, normals, texCoord)
		
	}
	
	public init(_ pos: SIMD3<Float>, _ color: SIMD4<Float>, _ normals: SIMD3<Float>, texCoord: SIMD2<Float>){
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
