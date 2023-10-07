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

	public var transforms = Transforms()
    
	public var vertices: [Vertex] = []

	public init(named : String, x: Float, y: Float, z: Float, r: Float, g: Float, b: Float, a: Float){
		self.name = named
		position(x: x, y: y, z: z)
		createVertices(r: r, g: g, b: b, a: a)`
	}
	open func createVertices(r: Float, g: Float, b: Float, a: Float){ }
	
    
}
