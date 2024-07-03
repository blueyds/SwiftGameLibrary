
import ModelIO

public class Cylinder: ModelIOMesh{
	public var mesh: MTKMesh? = nil
	
	public init(using device: any MTLDevice){
		let model = MDLMesh(cylinderWithExtent: .one,
						segments: 30,
						inWardNormals: false,
						topCap: true,
						bottomCap: true,
						geoometryType: .triangles,
						allocator: nil)
		load(mdlMesh: model, using: device)
	}
	
}