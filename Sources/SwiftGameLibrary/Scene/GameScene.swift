import Metal
import simd

open class GameScene:Nameable, Identifiable, Actionable, HasChildren{
	public var name: String
	public var id: Int
	public var children: [String: GameNode] = [:]
	public var camera: CameraNode!
	public var actions: [any Action] = []
	public var lights: [LightNode] = []
	public var meshes: [String: Mesh] = [:]
	public let engine: MainEngine
	public init(named: String, using engine: MainEngine){
		self.name = named
		self.id = Int.NextID()
		self.engine = engine
		children = [:]
		actions = []
		lights = []
		meshes = [:]
		buildMeshes()
		buildScene()
		findAllLights()
		findCamera()
	}
	
	public func add(child: GameNode){
		children.updateValue(child, forKey: child.name)
	}
	
	
	open func buildMeshes() { }
	open func buildScene() { }
	
	open func doUpdate(counter ticks: TickCounter) { }
	
	public func getLightData()->[LightData]{
		var result: [LightData] = []
		lights.forEach(){ light in
			let data = LightData(
				position: light.position,
				color: light.color,
				brightness: light.brightness,
				ambienceIntensity: light.ambienceIntensity,
				diffuseIntensity: light.diffuseIntensity,
				specularIntensity: light.specularIntensity
			)
			result.append(data)
		}
		return result
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
		updateChildMatrices(parentMatrix: .identity, viewMatrix: camera.getViewMatrix() )
	}
}
// camear function
extension GameScene{
	public func findCamera(){
		var cameras: [String: CameraNode] = [:]
		for key in children.keys {
			if let cam = children[key]! as? CameraNode{
				cameras.updateValue(cam, forKey: key)
			}
		}
		if cameras.isEmpty { fatalError("No camera")}
		cameras.forEach{ cam in
			camera = cam.value
			children.removeValue(forKey: cam.key)
		}
	}
	
	public func viewPortChanged(to newSize: (width: Float, height: Float)){
		camera.changeViewportSize(to: newSize)
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
		// TODO: does cameraPOsition need to be reversed?
		var lights = getLightData()
		var count = UInt32(lights.count)
		var scene = SceneConstants(
			viewMatrix: camera.getViewMatrix(),
			projectionMatrix: camera.getProjectionMatrix(),
			cameraPos: camera.position,
			light: lights.first ?? LightData.noLight
		)
		
		encoder.setVertexBytes(&scene, length: SceneConstants.stride(), index: VertexParameters.SceneConstants)
		encoder.setFragmentBytes(&count, length: UInt32.stride(), index: FragmentParameters.LightCount)
		encoder.setFragmentBytes(&lights, length: LightData.stride(of: lights.count), index: FragmentParameters.Lights)
		renderChildren(with: encoder, currentState)
		encoder.popDebugGroup()
	}
}


