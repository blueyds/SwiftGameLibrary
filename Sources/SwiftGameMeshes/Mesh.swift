import Metal
import SwiftGameTypes

public protocol Mesh: AnyObject{
	func render(with: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState)
	func drawPrimitives(using: MTLRenderCommandEncoder)
	func setVertices(to: MTLRenderCommandEncoder)
	func setPipelineState(on: MTLRenderCommandEncoder, _ didChange: inout Bool)
	func getBoundingBox(center: SIMD3<Float>, scaledBy: SIMD3<Float>)->AABB
}

extension Mesh{
	public func setVertices(to: MTLRenderCommandEncoder) {}
	
	public func setPipelineState(on: MTLRenderCommandEncoder, _ didChange: inout Bool){ didChange = false }
	
	// default implementation will present a Cube Box that fills a normal 
	// 2 X 2 X 2 basically from -1 to +1
	public func getBoundingBox(center: SIMD3<Float>, scaledBy: SIMD3<Float>)->AABB{
		AxisAlignedBoundingBox(worldPos: center, extantX: scaledBy.x, extantY: scaledBy.y, extantZ: scaledBy.z)
	}
	
	public func render(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		var didChange: Bool = false
		setPipelineState(on: encoder, &didChange)
		setVertices(to: encoder)
		drawPrimitives(using: encoder)
		if didChange {
			encoder.setRenderPipelineState(currentState)
		}
	}
}