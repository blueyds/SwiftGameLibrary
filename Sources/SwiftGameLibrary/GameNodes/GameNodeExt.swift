//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 6/24/24.
//

import Foundation
import simd

extension GameNode {
	public func PositionAt(x: Float, y: Float, z: Float)->GameNode{
		let result = self
		result.transforms.position = SIMD3(x, y, z)
		return result
	}

	public func ScaledBy(x: Float, y: Float, z: Float)->GameNode{
		let result = self
		result.transforms.scale = SIMD3(x, y, z)
		return result
	}

	public func ScaledBy(all: Float)->GameNode{
		ScaleBy(x: all, y: all, z: all)
	}

}
