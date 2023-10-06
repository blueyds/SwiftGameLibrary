import Foundation
import Metal
import simd

public protocol Renderable: Nameable , Transformable{
    func render(using: MTLRenderCommandEncoder, pipelineChanged: inout Bool)
}

extension Renderable{
    public func assignModelConstants(to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&transforms.matrix, length: Matrix.stride(), index: BufferIndex.ModelMatrix)
	}
}


