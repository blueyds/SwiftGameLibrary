import Metal
import simd

open class GameScene:Nameable, Identifiable, Actionable, HasChildren{
	public var name: String
	public var id: Int
	public var children: [GameNode] = []
	public var camera: Camera!
	public var actions: [any Action] = []
	private var garbageCounter: Int = 15
	public var lights: [LightNode] = []
	public init(named: String){
		self.name = named
		self.id = Int.NextID()
	}
	
	public init(){
		self.id = Int.NextID()
		self.name = "SCENE_id\(self.id)"
	}

	open func doUpdate(counter ticks: TickCounter) { }
	
	public func attachLights(to encoder: MTLRenderCommandEncoder){
		var count: Int16 = lights.count
		encoder.setFragmentBytes(&count, length: Int16.stride, index: FragmentParameters.LightCount)
		if count > 0{
			encoder.setFragmentBytes(&lights[0].position, length: SIMD3<Float>.stride, index: FragmentParameters.LightPosition)
			encoder.setFragmentBytes(&lights[0].color, length: SIMD3<Float>.stride, index: FragmentParameters.LightColor)
			encoder.setFragmentBytes(&lights[0].intensity, SIMD4<Float>.stride, index: FragmentParameters.LightIntensity)
		}
	}
}

// Update functions
extension GameScene{
	
	public func findAllLights(){
		lights = []
		getAllChildren().forEach(){child in
			if let light = child as? LightNode{
				lights.append(light)
			}
		}
	}
	
	public func updateScene(counter ticks: TickCounter){
		doUpdate(counter: ticks)
		runActions(counter: ticks)
		updateChildren(counter: ticks)
		updateChildMatrices(parentMatrix: .identity)
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
		encoder.setVertexBytes(&camera.position, length: SIMD3<Float>.stride, index: VertexParameters.CameraPosition)0
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