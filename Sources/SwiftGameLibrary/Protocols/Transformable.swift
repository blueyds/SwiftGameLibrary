import simd

public protocol Transformable: AnyObject{
    var modelMatrix: matrix { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: matrix = matrix.identity){
        var result = matrix.identity
        result = matrixTranslationModel(from: result)
        result = matrixXRotationModel  (from: result)
        result = matrixYRotationModel  (from: result)
        result = matrixZRotationModel  (from: result)
		result = matrixScaleModel      (from: result)
		modelMatrix = matrix_multiply(parent, result)
//		return result
    }

}

