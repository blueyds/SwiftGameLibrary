import Foundation
import Metal
import simd

public protocol Renderable: Nameable , Transformable{
    // var pipelineState: MTLRenderPipelineState? { get }
    // return false if the renderpipeline state was changed
    func render(using: MTLRenderCommandEncoder)-> Bool
	func drawPrimitives(using: MTLRenderCommandEncoder)

}

extension Renderable{
    public func getPipelineState() -> MTLRenderPipelineState? { nil }
	public func assignModelConstants(to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&modelMatrix, length: matrix.stride(), index: BufferIndex.ModelMatrix)

	}
	public func render(using encoder:MTLRenderCommandEncoder) -> Bool{
		assignModelConstants(to: encoder)
		drawPrimitives(using: encoder)
		return true
	}
}


