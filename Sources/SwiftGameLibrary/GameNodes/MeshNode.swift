import Metal

public class MeshNode: GameNode{
	
	let mesh: Mesh
	
	public var color: SIMD4<Float> = Color.random.vector
	
	public var ambient: SIMD3<Float> = .one
	public var diffuse: SIMD3<Float> = .one
	public var specular: SIMD3<Float> = .one
	public var shininess: Float = 1
	
	public init(named name: String, mesh: Mesh){
		self.mesh = mesh
		super.init(named: name)
	}
	public func assignMaterials(to encoder: MTLRenderCommandEncoder){
		encoder.setFragmentBytes(&color, length: SIMD4<Float>.stride(), index: FragmentParameters.Color)
		encoder.setFragmentBytes(&ambient, length: SIMD3<Float>.stride(), index: FragmentParameters.Ambient)
		encoder.setFragmentBytes(&diffuse, length: SIMD3<Float>.stride(), index: FragmentParameters.Diffuse)
		encoder.setFragmentBytes(&specular, length:SIMD3<Float>.stride() index: FragmentParameters.Specular)
		encoder.setFragmentBytes(&shininess, length: Float.stride(), index: FragmentParameters.Shininess)
	}
	
	override func doRender(with encoder: MTLRenderCommandEncoder, _ currentState: MTLRenderPipelineState){
		assignMaterials(to: encoder)
		mesh.render(with: encoder, currentState, modelMatrix: modelMatrix)
	}
}