extension Array {
    public mutating func append(_ newElement: Element, count: Int){
        for var _ in 1...count{
            append(newElement)
        }
    }
}