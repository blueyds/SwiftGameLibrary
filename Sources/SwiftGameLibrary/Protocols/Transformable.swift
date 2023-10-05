import simd

public protocol Transformable: AnyObject{
    var modelMatrix: matrix { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: matrix = matrix.identity){
        var result = matrix.identity
        if let translate = self as? Translatable{
            result.translateModel(translate.position)
        }
        if let rotate = self as? Rotatable {
            result.rotate(rotate.rotation)
        }
        if let scale = self as? Scaleable {
            result.scale(scale.scale)
        }
        modelMatrix = matrix_multiply(parent, result)
    }

}

