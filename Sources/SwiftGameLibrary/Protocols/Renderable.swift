import Metal

public protocol Renderable: Nameable{
    func render(using: MTLRenderCommandEncoder, pipelineChanged: inout Bool)
	//func drawPrimitives(using: MTLRenderCommandEncoder)

}



