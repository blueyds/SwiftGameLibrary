import Metal
import simd

public protocol GameScene: AnyObject, Nameable, Identifiable{
    var children: [GameNode] { get set }
	var camera: Camera { get }
	
	func update(counter: TickCounter)
	
    /// pipelines should contain at least one reference
    /// the first pipeline will be used by the 
    /// default renderer. If a scene has custom
    /// pipelines then it should pass those onto
    /// custom objects as it defines them.
    /// If an object changes teh state, then the 
    /// default renderScene will go back to the
    /// default pipeline when exiting from that object
    /// renderScene should issue rendercommands onto 
    /// the encoder passed using various objects
    /// render function. It should know what pipeline
    /// was used going into a render function in case
    /// that object changed the pipeline
    func renderScene(using : MTLRenderCommandEncoder, currentState: MTLRenderPipelineState)
    //func updateScene()
    
}

extension GameScene{
	public func update(counter ticks: TickCounter){	}
	
    public func updateScene(counter ticks: TickCounter){
		update(counter: ticks)
        children.forEach(){
            $0.updateAll(counter: ticks)
        }
        children.forEach(){
            $0.updateMatrices(parent: Matrix.identity)
        }
    }

    public func renderScene(using encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        encoder.pushDebugGroup("SCENE \(name)")
        
        camera.render(using: encoder)
        children.forEach() { $0.renderAll(with: encoder, currentState: currentState)}
        
        encoder.popDebugGroup()
    }
    
    public func changeAspectRatio(_ newRatio: Float){
        camera.changeAspectRatio(newRatio)
    }
    
    public func add(child: GameNode){
        children.append(child)
    }
}
