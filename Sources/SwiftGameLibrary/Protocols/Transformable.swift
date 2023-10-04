import simd

public protocol Transformable{
    var modelMatrix: simd_float4x4 { get set }
}

extension Transformable{
    public func calculateModelMatrix(parent: simd_float4x4 = matrix_identity_float4x4)-> simd_float4x4{
        var result = matrix_identity_float4x4
        if let translate = self as? Translatable{
            result.translateModel(translate.position)
        }
        if let rotate = self as? Rotatable {
            result.rotate(rotate.rotation)
        }
        if let scale = self as? Scaleable {
            result.scale(scale.scale)
        }
        return matrix_multiply(parent, result)
//		return result
    }

}

