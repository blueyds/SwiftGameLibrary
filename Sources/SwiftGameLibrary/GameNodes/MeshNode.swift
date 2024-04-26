import Metal

public class MeshNode: GameNode{
	
	let mesh: Mesh
	
	public init(named name: String, mesh: Mesh){
		self.mesh = mesh
		super.init(named: name)
	}
	
	override func doRender(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		mesh.render(with: encoder, currentState, modelMatrix: modelMatrix)
	}
}