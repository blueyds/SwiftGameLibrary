
import simd
public class Sphere: VertexCollection{
    public init(color: Color){
        let name = "SPHERE_\(color)"
        super.init(named: name)
        createSphere( color)
        finishedBuilding()
       // print("Built \(vertexCount) vertices")
    }
    
    private func createSphere(_ color: Color){
        let stacks: Int = 8
        let slices: Int = 8
        var vectors: [SIMD3<Float>] = []
        for stack in 0...stacks{
            let phi:Float = (Float(stack) / Float(stacks)) * Float.pi
            for slice in 0...slices {
                let theta:Float = (Float(slice) / Float(slices)) * Float.pi * 2
                let x:Float = cos(theta) * sin(phi)
                let y:Float = cos(phi)
                let z:Float = sin(theta) * sin(phi)
                vectors.append(SIMD3<Float>(x,y,z))
            }
        }
        //print(vectors.count)
        for i1 in vectors.indices{
            // each triangle will be /\/
            guard let i2 = vectors.index(i1, offsetBy: slices + 1, limitedBy: vectors.endIndex - 1) else { continue }
            guard let i3 = vectors.index(i1, offsetBy: slices, limitedBy: vectors.endIndex - 1) else { continue }
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
