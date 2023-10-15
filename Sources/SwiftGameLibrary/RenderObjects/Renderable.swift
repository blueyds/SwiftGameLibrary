import Foundation
import Metal
import simd

public protocol Renderable: Nameable , Transformable{
// when you call render on a child node pass your current stte to that node
// all nodes should reset the state when they exit if they change.
    func render(using: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState)
    func setVertices(to: MTLRenderCommandEncoder)
    func assignModelConstants(to: MTLRenderCommandEncoder)
    func setPipelineState(on: MTLRenderCommandEncoder, didChange: inout Bool)
    func drawPrimitives(using: MTLRenderCommandEncoder)
}

extension Renderable{
    // defaults to assign the transforms matrix to the model
    public func assignModelConstants(to encoder: MTLRenderCommandEncoder){
		encoder.setVertexBytes(&matrices[0], length: Matrix.stride(), index: BufferIndex.ModelMatrix)
	}
    public func setVertices(to: MTLRenderCommandEncoder) {}
    public func setPipelineState(on: MTLRenderCommandEncoder, didChange: inout Bool){ didChange = false }
    
    public func render(using encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        encoder.pushDebugGroup(name)
        var didChange: Bool = false
        setPipelineState(on: encoder, &didChange)
        setVertices(to: encoder)
        assignModelConstants(to: encoder)
        drawPrimitives(using: encoder)
        if didChange {
            encoder.setRenderPipelineState(currentState)
        }
        encoder.popDebugGroup()
    }
}


