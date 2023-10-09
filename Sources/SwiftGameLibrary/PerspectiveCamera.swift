import simd
// TODO: refacytor to a camera protocil with a viewmatrix and projection mtraix that is transformable
// TODO: this is lilke a perspective camera
// see https://markdaws.net/blog/2019-12-17-toy3d/#_perspectivecamera

public class PerspectiveCamera: Camera, Identifiable{
    public let name: String = "Perspective Camera"
    public let id: Int = Int.NextID()
    public var transforms: Transforms = Transforms() 
        { didset{ didViewChange = true } }
    public var origin: float3{
        get{
            transforms.position
        }
        set(newOrigin){
            transforms.position = newOrigin
        }
    }
    public var lookAt: float3 = float3.Zero
        { didset{ didViewChange = true } }
    // up is the rotation. when we move our head left to right, our vector look does not change. This handles that.
    public var up: float3 = float3(0,1,0)
        { didset{ didViewChange = true } }
    public var fov: Float = 90 
        { didset{ didProjectionChange = true } }
    public var aspectRatio: Float = 1
        { didset{ didProjectionChange = true } }
    public var near: Float = 1
        { didset{ didProjectionChange = true } }
    public var far: Float = 1000
        { didset{ didProjectionChange = true } }
    private var didViewChange: Bool = true
    private var didProjectionChange: Bool = true
    private var _viewMatrix: Matrix = Matrix.identity
    private var _projectionMatrix: Matrix = Matrix.identity
    public var viewMatrix: Matrix {
        if didViewChange {
            let result = Matrix.identity
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
            let result = Matrix.identity
            result.perspective(degreesFov: fov, aspectRatio: aspectRatio, nearZ: near, farz: far)
            _projectionMatrix = result
            didProjectionChange = false
            return result
        } else {
            return _projectionMatrix
        }
    }    
    
}
