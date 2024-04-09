extension Array {
    public mutating func append(_ newElement: Element, count: Int){
        for let _ in 1...count{
            append(newElement)
        }
    }
}