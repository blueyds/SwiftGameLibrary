
import simd
import Metal
public class Sphere: VertexCollection{
	public var vertices: [Vertex] = []
	public var vertexBuffer: MTLBuffer? = nil
	//public var name: String = "SPHERE"
	let resolution: Int
	public init(using device: MTLDevice, resolution: Int){
		self.resolution = resolution
		build(using: device)
	}
	
	public func getBoundingBox(center: SIMD3<Float>,scaledBy: SIMD3<Float>)->AABB{
		// we can use extant version bercause the unscaled Sphere is 2 X 2 X 2
		let min = vertices.min()!
		let max = vertices.max()!
		return AxisAlignedBoundingBox(min: min.position, max: max.position)
	}
    public func createVertices(){
		createSphere(.random)
    }
    private func createSphere(_ color: Color){
		var vectors: [SIMD3<Float>] = []
        for stack in 0...resolution{
            let phi:Float = (Float(stack) / Float(resolution)) * Float.pi
            for slice in 0...resolution {
                let theta:Float = (Float(slice) / Float(resolution)) * Float.pi * 2
                let x:Float = cos(theta) * sin(phi)
                let y:Float = cos(phi)
                let z:Float = sin(theta) * sin(phi)
                vectors.append(SIMD3<Float>(x,y,z))
            }
        }
        //print(vectors.count)
        for i1 in vectors.indices{
            // each triangle will be /\/
            guard let i2 = vectors.index(i1, offsetBy: resolution + 1, limitedBy: vectors.endIndex - 1) else { continue }
            guard let i3 = vectors.index(i1, offsetBy: resolution, limitedBy: vectors.endIndex - 1) else { continue }
            guard let i4 = vectors.index(i1, offsetBy: 1, limitedBy: vectors.endIndex - 1) else { continue }
            // add 1, 2, 3
            // add 4, 5, 6
            let indices: [Int] = [i1, i2, i3, i1, i4, i2]
            //print("\(indices.max()) \(vectors.endIndex)")
            for index in indices {
                let v = vectors[index]
                add(v.x, v.y, v.z, color)
            }
        }
    }
}
