extension Array {
    public mutating func append(_ newElement: Element, count: Int){
        for _ in 1...count{
            append(newElement)
        }
    }
}

extension Array where Element == SIMD3<Float>{
    public func sum()->SIMD3<Float>{
        reduce(SIMD3<Float>(0, 0, 0)){  
          var result = $0
            result.x += $1.x
            result.y += $1.y
            result.z += $1.z
            return result
        }
    }
    public func average()->Element{
        let summary = sum()
        let scale: Float = 1.0 / Float(count)
        return summary * scale
    }
}

