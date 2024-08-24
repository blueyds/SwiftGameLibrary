import simd

extension Array {
    public mutating func append(_ newElement: Element, count: Int){
        for _ in 1...count{
            append(newElement)
        }
    }
}
extension Array where Element:SIMD, Element.Scalar:FloatingPoint{
    public func sum()->Element{
        reduce(Element.zero){  $0 + $1 }
    }
    public func average()->Element{
        let scale = Element(repeating: Element.Scalar(self.count))
        return  sum() / scale
    }
}
