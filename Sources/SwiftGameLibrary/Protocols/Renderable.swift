import Metal

public protocol Renderable: Transformable, Nameable{
    func render(using: MTLRenderCommandEncoder, pipelineChanged: inout Bool)
	//func drawPrimitives(using: MTLRenderCommandEncoder)

}



