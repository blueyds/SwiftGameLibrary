import simd
// TODO: refacytor to a camera protocil with a viewmatrix and projection mtraix that is transformable
// TODO: this is lilke a perspective camera
// see https://markdaws.net/blog/2019-12-17-toy3d/#_perspectivecamera

public final class PerspectiveCamera: Camera, Identifiable{
    public let name: String = "Perspective Camera"
    public let id: Int = Int.NextID()
    public var transforms: Transforms { didset { didViewChange = true } }
    public var origin: float3{
        get{
            transforms.position
        }
        set(newOrigin){
            transforms.position = newOrigin
        }
    }
    public var lookAt: float3 { didset { didViewChange = true } }
    // up is the rotation. when we move our head left to right, our vector look does not change. This handles that.
    public var up: float3 { didset { didViewChange = true } }
    public var fov: Float { didset { didProjectionChange = true } }
    public var aspectRatio: Float { didset { didProjectionChange = true } }
    public var near: Float { didset { didProjectionChange = true } }
    public var far: Float { didset { didProjectionChange = true } }
    private var didViewChange: Bool = true
    private var didProjectionChange: Bool = true
    private var _viewMatrix: Matrix = Matrix.identity
    private var _projectionMatrix: Matrix = Matrix.identity
    public var viewMatrix: Matrix {
        if didViewChange {
            var result = Matrix.identity
            result.look(eye: origin, look: lookAt, up: up)
            _viewMatrix = result
            didViewChange = false
            return result
        } else {
            return _viewMatrix
        }
    }
    public var projectionMatrix: Matrix {
        if didProjectionChange {
            var result = Matrix.identity
            result.perspective(degreesFov: fov, aspectRatio: aspectRatio, nearZ: near, farz: far)
            _projectionMatrix = result
            didProjectionChange = false
            return result
        } else {
            return _projectionMatrix
        }
    }
    
    public init(name: String){
      self.transforms = Transforms()
        self.name = name
        self.lookAt = float3.Zero
        self.up = float3(0,1,0)
        self.fov = 90
        self.aspectRatio = 1
        self.near = 1
        self.far = 1000  
    }
    public init(name: String, origin: float3, lookAt: float3, up: float3, fov: Float, aspectRatio: Float, near: Float, far: Float ){
        self.transforms = Transforms()
        self.name = name
        self.origin = origin
        self.lookAt = lookAt
        self.up = up
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.near = near
        self.far = far
    }
    
}
