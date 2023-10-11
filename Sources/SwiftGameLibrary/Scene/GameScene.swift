import Metal
import simd

public protocol GameScene: AnyObject, Nameable, Identifiable{
    var children: [any GameNode] { get set }
    
    /// pipelines should contain at least one reference
    /// the first pipeline will be used by the 
    /// default renderer. If a scene has custom
    /// pipelines then it should pass those onto
    /// custom objects as it defines them.
    /// If an object changes teh state, then the 
    /// default renderScene will go back to the
    /// default pipeline when exiting from that object
    var pipelines: [MTLRenderPipelineState] { get }
    /// renderScene should issue rendercommands onto 
    /// the encoder passed using various objects
    /// render function. It should know what pipeline
    /// was used going into a render function in case
    /// that object changed the pipeline
    func renderScene(using : MTLRenderCommandEncoder)
    //func updateScene()
    var camera: Camera { get }
    
}

extension GameScene{
    public func updateScene(){
        if let updateMe = self as? Updateable {
            updateMe.doUpdate()
        }
        if let updateCamera = camera as? Updateable{
            updateCamera.doUpdate()
        }
        children.forEach(){
            $0.updateMeAndChildren()
        }
        children.forEach(){
            $0.updateMatrices(parent: Matrix.identity)
        }
    }

    public func renderScene(using encoder: MTLRenderCommandEncoder){
        encoder.pushDebugGroup(name)
        encoder.setRenderPipelineState(pipelines[0])
        camera.render(using: encoder, currentState: pipelines[0])
        
        children.forEach() { $0.renderAll(with: encoder, currentState: pipelines[0])}
        
        encoder.popDebugGroup()
    }

}
