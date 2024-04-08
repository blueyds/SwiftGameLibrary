extension Array {
    public mutating func append(_ newElement: Element, count: Int){
        for var x in 1...count{
            append(newElement)
        }
    }
}