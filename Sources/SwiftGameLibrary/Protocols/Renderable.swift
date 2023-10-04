import Metal

public protocol Renderable: Transformble, Nameable{
    func render(using: MTLRenderCommandEncoder, pipelineChanged: inout Bool)
	//func drawPrimitives(using: MTLRenderCommandEncoder)

}



