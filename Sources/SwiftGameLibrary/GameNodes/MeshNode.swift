import Metal

public class MeshNode: GameNode{
	public let id: Int = Int.NextID()
	
	public var transforms: [Transformable] = [Transformable()]

	public var children: [any GameNode] = []

	public var actions: [Action] = []
	
	var mesh: [any Mesh] = []

	public var material: MaterialData


	public init(mesh: any Mesh, color: Color = Color.random, isLit: Bool = true, ambient: SIMD3<Float> = SIMD3<Float>(repeating: 0.1), diffuse: SIMD3<Float> = .one, specular: SIMD3<Float> = .one, shininess: Float = 50, named: String? = nil){
		material = MaterialData(color: color.rgba, isLit: isLit, ambient: ambient, diffuse: diffuse, specular: specular, shininess: shininess)
		self.mesh.append(mesh)
	}
	
	func assignDefaultBuffers(to encoder: MTLRenderCommandEncoder){
		var model = ModelConstants(modelMatrix: transforms[0].modelMatrix, normalMatrix: transforms[0].normalMatrix, material: material )
		 encoder.setVertexBytes(&model, length: ModelConstants.stride(), index: VertexParameters.ModelConstants)
	 }
	
	public func doRender(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		assignDefaultBuffers(to: encoder)
		mesh[0].render(with: encoder, currentState)
	}
	
	 public func isHitTested(ray: Ray, parentScale: SIMD3<Float> = .one)->HitResult?{
		//let newScale = parentScale * scale
		 let box = mesh[0].getBoundingBox(center: transforms[0].modelMatrix.xyz, scaledBy: parentScale * transforms[0].scale)
		if let hit = box.intersect(ray){
			return HitResult(node: self,
						ray: ray,
						parameter: hit,
							 worldPos: transforms[0].worldPos)
		} else {
			return hitTestAllChildren(ray: ray, parentScale: parentScale)
		}
	}
}
