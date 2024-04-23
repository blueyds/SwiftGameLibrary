import Metal
import simd

open class GameScene:Nameable, Identifiable, Actionable, HasChildren{
    public var name: String
    public var id: Int
	public var children: [GameNode] = []
	public var camera: Camera!
	// needed by hasChidren
	public var position: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
	public var rotation: SIMD3<Float> = .zero
	public var modelMatrix: Matrix = .identity
	// end needed by hasChildren
	public var actions: [any Action] = []
	private var garbageCounter: Int = 15
    
	public init(named: String){
        self.name = named
		self.id = Int.NextID()
	}
	
	public init(){
		self.id = Int.NextID()
		self.name = "SCENE_id\(self.id)"
	}

	open func doUpdate(counter ticks: TickCounter) { }
	
	open func attachLights(to encoder: MTLRenderCommandEncoder){ }
}

// Update functions
extension GameScene{
	
	
    public func updateScene(counter ticks: TickCounter){
		doUpdate(counter: ticks)
		runActions(counter: ticks)
        updateChildren(counter: ticks)
		updateChildMatrices()
    }
}

// Render functions
extension GameScene{
	
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
	public func renderScene(with encoder: MTLRenderCommandEncoder, currentState: MTLRenderPipelineState){
        encoder.pushDebugGroup("SCENE \(name)")
        
        camera.render(with: encoder)
		attachLights(to: encoder)
        renderChildren(with: encoder, currentState)
        
        encoder.popDebugGroup()
    }
}


// Miscellaneous Functions
extension GameScene{    
    public func changeAspectRatio(_ newRatio: Float){
        camera.changeAspectRatio(newRatio)
    }
}