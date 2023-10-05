import simd
import Metal

public protocol Transformable: Translatable, Rotatable, Scaleable{
    var modelMatrix: matrix { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: matrix = matrix_identity_float4x4)-> matrix{
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

