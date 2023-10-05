//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 9/30/23.
//

import simd
public typealias float3 = simd_float3
public typealias float4 = simd_float4

extension float3{
	public static var Zero: float3 { float3(repeating: 0)}
	public static var One: float3 { float3(repeating: 1)}
}

extension float4{
	public static var Zero: float4 { float4(repeating: 0) }
	public static var One: float4 { float4(repeating: 1) }
}