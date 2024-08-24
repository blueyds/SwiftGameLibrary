import Foundation

public struct Ray { 
	public var origin: SIMD3<Float>
	public var direction: SIMD3<Float>
	public var invertedDirection: SIMD3<Float>
	public init(origin: SIMD3<Float>, direction: SIMD3<Float>){
		self.origin = origin
		self.direction = direction
		invertedDirection = 1 / direction
	}
}