import simd
// TODO: refacytor to a camera protocil with a viewmatrix and projection mtraix that is transformable
// TODO: this is lilke a perspective camera
// see https://markdaws.net/blog/2019-12-17-toy3d/#_perspectivecamera

public class PerspectiveCamera: Camera, Identifiable{
    public let name: String
    public let id: Int = Int.NextID()
    public var transforms: Transforms
    // public var lookAt: float3 
    // up is the rotation. when we move our head left to right, our vector look does not change. This handles that.
    // public var up: float3
    public var fov: Float
    public var aspectRatio: Float
    public var near: Float
    public var far: Float
    public var viewMatrix: Matrix {
        Matrix.view(position: transforms.position)
    }
    public var projectionMatrix: Matrix {
        Matrix.perspective(degreesFov: fov, aspectRatio: aspectRatio, nearZ: near, farZ: far)
    }
    
    public init(named: String){
      self.transforms = Transforms()
        self.name = named
        self.fov = 90
        self.aspectRatio = 1
        self.near = 1
        self.far = 1000  
    }
    public init(named: String, origin: float3, fov: Float, aspectRatio: Float, near: Float, far: Float ){
        self.transforms = Transforms(position: origin, rotation: float3.Zero, scale: float3.One)
        self.name = named
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.near = near
        self.far = far
    }
    
}
