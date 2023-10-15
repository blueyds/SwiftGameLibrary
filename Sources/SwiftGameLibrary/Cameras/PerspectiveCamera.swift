import simd

public class PerspectiveCamera: Camera, Identifiable{
    public let name: String
    public let id: Int = Int.NextID()
    public var transforms = [Transforms()]
    public var matrices: [Matrix] = []
    public var fov: Float
    public var aspectRatio: Float
    public var near: Float
    public var far: Float
    public var viewMatrix: Matrix {
        Matrix.view(position: transforms[0].position)
    }
    public var projectionMatrix: Matrix {
        Matrix.perspective(degreesFov: fov, aspectRatio: aspectRatio, nearZ: near, farZ: far)
    }
    
    public init(named: String){
        self.name = named
        self.fov = 90
        self.aspectRatio = 1
        self.near = 1
        self.far = 1000  
    }
    public init(named: String, origin: float3, fov: Float, aspectRatio: Float, near: Float, far: Float ){
        self.transforms = [Transforms(position: origin, rotation: float3.Zero, scale: float3.One)]
        self.name = named
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.near = near
        self.far = far
    }
    public func changeAspectRatio(_ ratio: Float){
        self.aspectRatio = ratio
    }
}
