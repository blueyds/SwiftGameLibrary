import simd
import Metal

public class BasicCamera: Camera{
    public var name: String
    public var id: Int = Int.NextID()
    public var fov: Float = 90
    public var aspectRatio: Float = 1
    public var near: Float = 1
    public var far: Float = 1000
    public var position = simd_float3.Zero
    public var rotation = simd_float3.Zero
    public var scale = simd_float3.One
    public var modelMatrix = matrix_identity_float4x4
    
    public init(name: String, fov: Float, aspectRatio: Float, near: Float, far: Float){
        self.name = name
        self.fov = fov
        self.aspectRatio = aspectRatio
        self.near = near 
        self.far = far
    }
    public init(name: String){
        self.name = name
    }
    public func render(using encoder: MTLRenderCommandEncoder,pipelineChanged: inout Bool){
        modelMatrix.translateView(position)
        encoder.setVertexBytes(&modelMatrix, length: matrix_float4x4.stride(), index: BufferIndex.ViewMatrix)
        var projection = projectionMatrix()
        encoder.setVertexBytes(&projection, length: matrix_float4x4.stride(), index: BufferIndex.ProjectionMatrix)
        pipelineChanged = false
    }
    
}