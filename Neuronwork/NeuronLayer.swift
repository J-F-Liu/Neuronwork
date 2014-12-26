class NeuronLayer {
    
    var neurons:[Neuron]
    
    // a matrix of weights, each row is the weight vector of a neuron,
    // the matrix has the same number of rows as its neurons
    var weight:[[Real]]
    
    // a column vector of biases from neurons
    var bias:[Real]
    
    init(neurons:[Neuron]){
        self.neurons = neurons
        self.weight = neurons.map{neuron in neuron.weight}
        self.bias = neurons.map{neuron in neuron.bias}
    }
    
    init(inputSize:Int, outputSize:Int, activationFuction:Real->Real){
        self.neurons = (1...outputSize).map{ _ in Neuron(inputSize: inputSize, activationFuction) }
        self.weight = neurons.map{neuron in neuron.weight}
        self.bias = neurons.map{neuron in neuron.bias}
    }
    
    func activate(input:[Real])->[Real]{
        var output = [Real]()
        for neuron in neurons{
            output.append(neuron.activate(input))
        }
        return output
    }
}