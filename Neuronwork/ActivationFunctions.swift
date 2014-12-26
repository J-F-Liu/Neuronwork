import Darwin

func randomFloat() -> Float {
    return Float(arc4random()) /  Float(UInt32.max)
}

struct ActivationFunctions {
    static let sigmod = { (x:Real)->Real in
        return 1/(1+Darwin.exp(-x))
    }
}