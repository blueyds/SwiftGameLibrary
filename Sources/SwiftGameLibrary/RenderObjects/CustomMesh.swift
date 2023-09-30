//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 9/30/23.
//

import simd
import Metal

open class CustomMesh: GameNode, Renderable{
	public var id = Int.NextID()

	public var name: String
	
	public var parent: (any GameNode)?

	public var children: [any GameNode] = []

	public var modelMatrix = matrix_identity_float4x4

	public var position = simd_float3.Zero

	public var rotation = simd_float3.Zero

	public var scale = simd_float3.One
	
	open var vertices: [Vertex] = []

	public init(named : String, x: Float, y: Float, z: Float){
		self.name = named
		self.position = simd_float3(x, y, z)
		createVertices()
	}
	open func createVertices(){ }
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder) {
		encoder.setVertexBytes(vertices, length: vertices.count * Vertex.stride(), index: 0)
		encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
	}
}
