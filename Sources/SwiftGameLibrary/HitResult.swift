import simd
import SwiftGameTypes

public struct HitResult{
	public var node: any GameNode
	public var ray: Ray
	public var parameter: Float
	public var topLevelNode: (any GameNode)? = nil
	public var worldPos: SIMD3<Float> = .zero
	public var intersectionPoint: SIMD3<Float> {
		ray.origin + parameter * ray.direction
	}
	public mutating func changeTopLevel(to: any GameNode){
		topLevelNode = to
	}
}

extension HitResult: CustomStringConvertible{
	public var description: String {
		"NODE:\(node.id) ray:\(ray) parameter:\(parameter) topLevelNode:\(topLevelNode?.id ?? "nil") worldPos:\(worldPos)"
	}
}
