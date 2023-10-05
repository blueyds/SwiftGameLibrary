//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 9/30/23.
//

import simd
import Metal

open class CustomMesh: GameNode, VertexCollection{
	public var id = Int.NextID()

	public var name: String
	
	//public var parent: (any GameNode)?

	public var children: [any GameNode] = []

	public var modelMatrix = matrix_identity_float4x4

	public var position = float3.Zero

	public var rotation = float3.Zero

	public var scale = float3.One
	
	public var vertices: [Vertex] = []

	public init(named : String, x: Float, y: Float, z: Float, r: Float, g: Float, b: Float, a: Float){
		self.name = named
		self.position = float3(x, y, z)
		createVertices(r: r, g: g, b: b, a: a)
	}
	open func createVertices(r: Float, g: Float, b: Float, a: Float){ }
	public func drawPrimitives(using encoder: MTLRenderCommandEncoder) {
		encoder.setVertexBytes(vertices, length: Vertex.stride(at: vertices.count), index: 0)
		encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
	}
}
