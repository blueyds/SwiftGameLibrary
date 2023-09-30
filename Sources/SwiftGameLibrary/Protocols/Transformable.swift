import simd
import Metal

public protocol Transformable: Translatable, Rotatable, Scaleable{
    var modelMatrix: simd_float4x4 { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: simd_float4x4 = matrix_identity_float4x4)-> simd_float4x4{
        var result = matrix_identity_float4x4
        result = translateModel(from: result)
        result = rotateXModel(from: result)
        result = rotateYModel(from: result)
        result = rotateZModel(from: result)
  
		result = scaleModel(from: result)
         return matrix_multiply(parent, result)
//		return result
    }

}

