import simd

public struct HitResult{
	public var node: GameNode
	public var ray: Ray
	public var parameter: Float
	public var topLevelNode: GameNode? = nil
	public var worldPos: SIMD3<Float> = .zero
	public var intersectionPoint: SIMD3<Float> {
		ray.origin + parameter * ray.direction
	}
	public mutating func changeTopLevel(to: GameNode){
		topLevelNode = to
	}
}

extension HitResult: CustomStringConvertible{
	public var description: String {
		"NODE:\(node.name) ray:\(ray) parameter:\(parameter) topLevelNode:\(topLevelNode?.name ?? "nil") worldPos:\(worldPos)"
	}
}
