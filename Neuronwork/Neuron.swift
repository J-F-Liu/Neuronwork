class Neuron {
    
    // an array of weights, has the same size as input values
    var weight:[Real]
    
    var bias:Real
    
    var activationFuction:Real->Real
    
    init(inputSize:Int, activationFuction:Real->Real){
        self.weight = (1...inputSize).map{ _ in randomFloat()}
        self.bias = randomFloat()
        self.activationFuction = activationFuction
    }
    
    func activate(input:[Real])->Real{
        var weightedInput = bias
        for index in 0..<input.count{
            weightedInput += input[index] * weight[index]
        }
        return activationFuction(weightedInput)
    }
}