import Metal

public class MeshNode: GameNode{
	
	let mesh: Mesh
	
	public var color: Color = Color.random
	
	public var isLit: Bool = true
	
	public var ambient: SIMD3<Float> = SIMD3<Float>(repeating: 0.1)
	public var diffuse: SIMD3<Float> = .one
	public var specular: SIMD3<Float> = .one
	
	public var shininess: Float = 50
	public init(mesh: Mesh, color: Color = Color.random, isLit: Bool = true, ambient: SIMD3<Float> = SIMD3<Float>(repeating: 0.1), diffuse: SIMD3<Float> = .one, specular: SIMD3<Float> = .one, shininess: Float = 50, named: String? = nil){
		self.mesh = mesh
		self.isLit = isLit
		self.ambient = ambient;
		self.diffuse = diffuse
		self.specular = specular
		self.shininess = shininess
		if let name = named {
			super.init(named: name)
		} else {
			super.init(prepend: "MESH")
		}
	}
	public init(named name: String, mesh: Mesh){
		self.mesh = mesh
		super.init(named: name)
	}
	 func assignDefaultBuffers(to encoder: MTLRenderCommandEncoder){
		 let material = MaterialData(
		 	color: color.rgba,
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