extension Array {
    public mutating func append(_ newElement: Element, count: Int){
        for _ in 1...count{
            append(newElement)
        }
    }
}

extension Array where Element == simd_float3{
    func sum()->simd_float3{
        reduce(simd_float3(0, 0, 0), { $0 + $1})
    }
    func average()->Element{
        let summary = sum()
        let scale: Float = 1.0 / Float(count)
        var result = summary * scale
        return result
    }
}
