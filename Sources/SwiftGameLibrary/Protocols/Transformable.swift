import simd
import Metal

public protocol Transformable: Translatable, Rotatable, Scaleable{
    var modelMatrix: simd_float4x4 { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: simd_float4x4 = matrix_identity_float4x4)-> simd_float4x4{
        var result = matrix_identity_float4x4
        result = matrixTranslationModel(from: result)
        result = matrixXRotationModel  (from: result)
        result = matrixYRotationModel  (from: result)
        result = matrixZRotationModel  (from: result)
		result = matrixScaleModel      (from: result)
		return matrix_multiply(parent, result)
//		return result
    }

}

