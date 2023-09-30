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
		encoder.setVertexBytes(&modelMatrix, length: simd_float4x4.stride(), index: 1)

	}
	public func render(using encoder:MTLRenderCommandEncoder) -> Bool{
		assignModelConstants(to: encoder)
		drawPrimitives(using: encoder)
		return true
	}
}


