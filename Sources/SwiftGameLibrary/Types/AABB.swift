import Foundation
import simd

public protocol AABB{
	func intersect(_ : Ray)->Float?
}

public struct AxisAlignedBoundingBox:AABB{
	var min: SIMD3<Float>
	var max: SIMD3<Float>
	public init(min: SIMD3<Float>, max: SIMD3<Float>){
		self.max = max
		self.min = min
	}
	public init(worldPos: SIMD3<Float>, lengthOnXAxis: Float, lengthOnYAxis: Float, lengthOnZAxis: Float){
		self.init(worldPos: worldPos, extantX: lengthOnXAxis / 2, extantY: lengthOnYAxis / 2, extantZ: lengthOnZAxis / 2)
	}
	public init(worldPos: SIMD3<Float>, extantX: Float, extantY: Float, extantZ: Float){
		min = simd_float3(worldPos.x - extantX, worldPos.y - extantY, worldPos.z - extantZ)
		max = simd_float3(worldPos.x + extantX, worldPos.y + extantY, worldPos.z + extantZ)
	}
	private func tMinMax(boxMin: Float, boxMax: Float, origin: Float, invertedDirection: Float)->(min: Float, max: Float){
		var result: (min: Float, max: Float) 
		if (invertedDirection <= 0) { 
			result = (
				min: (boxMin - origin) * invertedDirection,
				max: (boxMax - origin) * invertedDirection)
		}
		else { 
			result = (
				min: (boxMax - origin) * invertedDirection,
				max: (boxMin - origin) * invertedDirection
			)
		}
		// swap if min is greater than max
		if result.min > result.max {
			let temp = result
			result = (min: temp.max, max: temp.min)
		}
		return result
	}

	public func intersect(_ ray: Ray) -> Float?{
		let tx = tMinMax(boxMin: min.x, boxMax: max.x, origin: ray.origin.x, invertedDirection: ray.invertedDirection.x)
		let ty = tMinMax(boxMin: min.y, boxMax: max.y, origin: ray.origin.y, invertedDirection: ray.invertedDirection.y)
		let tz = tMinMax(boxMin: min.z, boxMax: max.z, origin: ray.origin.z, invertedDirection: ray.invertedDirection.z)
		if tx.min > ty.max { return nil }
		if ty.min > tx.max { return nil }
		var tmin = SIMD2(tx.min, ty.min).min()
		var tmax = SIMD2(tx.max, ty.max).max()
		if tmin > tz.max { return nil}
		if tz.min > tmax { return nil }
		tmin = SIMD2(tmin, tz.min).min()
		tmax = SIMD2(tmax, tz.max).max()
		if tmin < 0 && tmax < 0 { return nil }
		if tmin < 0 { return tmax }
		return tmin
	}
}
