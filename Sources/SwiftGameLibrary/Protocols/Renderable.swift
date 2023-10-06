import Foundation
import Metal
import simd

public protocol Renderable: Nameable , Transformable{
// when you call render on a child node pass your current stte to that node
// all nodes should reset the state when they exit if they change.
    func render(using: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState)
}

extension Renderable{
    public func assignModelConstants(to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&transforms.matrix, length: Matrix.stride(), index: BufferIndex.ModelMatrix)
	}
}


