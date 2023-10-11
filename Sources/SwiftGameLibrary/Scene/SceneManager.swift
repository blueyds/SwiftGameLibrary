import MetalKit

public protocol SceneManager{
    var currentScene: (any GameScene) { get set }
    var engine: MainEngine { get }
    var renderPipeline: MTLRenderPipelineState { get }
    var depthStencilState: MTLDepthStencilState { get } 
    
    func mainLoop(view: MTKView)
    func render(view: MTKView)
}


extension SceneManager{
    public func mainLoop(view: MTKView){
        currentScene.updateScene()
        render(view: view)
    }
    
    public func render(view: MTKView){
        guard let commandBuffer = engine.commandQueue?.makeCommandBuffer() else { return }
        guard let passDescriptor = view.currentRenderPassDescriptor else { return }
        guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor) else { return }
        if let drawable = view.currentDrawable{
            
            encoder.setRenderPipelineState(renderPipeline)
            encoder.setDepthStencilState(depthStencilState)
            
            currentScene.renderScene(using: encoder, currentState: renderPipeline)
            
            encoder.endEncoding()
			commandBuffer.present(drawable)
			commandBuffer.commit()
		}
    }
}
