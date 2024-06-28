public struct HitResult{
	public var node: GameNode
	public var ray: Ray
	public var parameter: Float
	public var topLevelNode: GameNode? = nil
	public var intersectionPoint: SIMD3<Float> {
		ray.origin + parameter * ray.direction
	}
	public mutating changeTopLevel(to: GameNode){
		topLevelNode = to
	}
}