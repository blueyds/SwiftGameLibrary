import MetalKit

public protocol SceneManager{
    func mainLoop(view: MTKView)
    func render(view: MTKView)
    var currentScene: GameScene? { get set }
    var engine: MainEngine? { get }
    
}
extension SceneManager{
    public func mainLoop(view: MTKView){
        currentScene?.updateScene()
        render(view: view)
    }
    
    public func render(view: MTKView){
        guard let commandBuffer = engine?.commandQueue?.makeCommandBuffer() else { return }
        guard let passDescriptor = view.currentRenderPassDescriptor else { return }
        guard let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor) else { return }
        if let drawable = view.currentDrawable{
            currentScene?.renderScene(using: encoder)
            encoder.endEncoding()
			commandBuffer.present(drawable)
			commandBuffer.commit()
		}
    }
}
