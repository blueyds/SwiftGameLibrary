import Metal

public class MeshNode: GameNode{
	
	let mesh: Mesh
	
	public var color: SIMD4<Float> = Color.random.vector
	
	public var isLit: Bool = true
	
	public var ambient: SIMD3<Float> = .one
	public var diffuse: SIMD3<Float> = .one
	public var specular: SIMD3<Float> = .one
	
	public var shininess: Float = 1
	
	public init(named name: String, mesh: Mesh){
		self.mesh = mesh
		super.init(named: name)
	}
	 func assignDefaultBuffers(to encoder: MTLRenderCommandEncoder){
		 let material = MaterialData(
		 	color: color,
			isLit: isLit,
			ambient: ambient,
			diffuse: diffuse,
			specular: specular,
			shininess: shininess
		 )
		 var model = ModelConstants(modelMatrix: modelMatrix, normalMatrix: normalMatrix, material: material )
		 encoder.setVertexBytes(&model, length: ModelConstants.stride(), index: VertexParameters.ModelConstants)
	 }
	
	override func doRender(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		assignDefaultBuffers(to: encoder)
		mesh.render(with: encoder, currentState)
	}
}