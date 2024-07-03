import Metal
import ModelIO

public class Cylinder: ModelIOMesh{
	public var mesh: MTKMesh? = nil
	
	public init(using device: any MTLDevice){
		let model = MDLMesh.newCylinder(
						withHeight: 2,
						radii: vector_float2(1,1),
						radialSegments: 30,
						verticalSegments: 5,
						geometryType: .triangles,
						inwardNormals: false,
						allocator: nil)
		load(mdlMesh: model, using: device)
	}
}