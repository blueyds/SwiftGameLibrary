import Metal
import simd
import SwiftGameTypes


public protocol GameScene: Nameable, Identifiable, HasChildren{
	var lightNodes: [LightNodes] { get}
    var camera: CameraNode! { get }
	func buildMeshes(engine: MainEngine)
	func buildScene(engine: MainEngine)
	func doUpdate(counter: TickCounter)
}

extension GameScene{

	public func buildMeshes(engine: MainEngine) { }

	public func buildScene(engine: MainEngine) { }

	public func doUpdate(counter ticks: TickCounter) { }

	

	internal func getLightData()->[LightData]{
		var result: [LightData] = []
		lightNodes.forEach(){ light in
			let data = LightData(
				position: light.transforms.position,
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
	
	public func findAllLights()->[LightNode]{
		var result: [LightNode] = []
		getAllChildren().forEach(){child in
			if let light = child as? LightNode{
				result.append(light)
			}
		}
		return result
	}
	
	
	public func updateScene(counter ticks: TickCounter){
		doUpdate(counter: ticks)
		//runActions(counter: ticks)
		updateChildren(counter: ticks)
		updateChildMatrices(parentMatrix: .identity, viewMatrix: camera.getViewMatrix() )
	}
}
// camear function
extension GameScene{
	public func findCameraInChildren()->CameraNode{
		var cameras: [CameraNode] = []
		for child in children {
			if let cam = child as? CameraNode{
				cameras.append(cam)
			}
		}
		if cameras.isEmpty { Log.error("No camera")}
		return cameras[0]
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
		let camera = getCamera()
		var scene = SceneConstants(
			viewMatrix: camera.getViewMatrix(),
			projectionMatrix: camera.getProjectionMatrix(),
			cameraPos: camera.transforms.position,
			light: lights.first ?? LightData.noLight
		)
		
		encoder.setVertexBytes(&scene, length: SceneConstants.stride(), index: VertexParameters.SceneConstants)
		encoder.setFragmentBytes(&count, length: UInt32.stride(), index: FragmentParameters.LightCount)
		encoder.setFragmentBytes(&lights, length: LightData.stride(of: lights.count), index: FragmentParameters.Lights)
		renderChildren(with: encoder, currentState)
		encoder.popDebugGroup()
	}
}


