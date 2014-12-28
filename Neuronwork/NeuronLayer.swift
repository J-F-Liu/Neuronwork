class NeuronLayer {
    
    var neurons:[Neuron]
    
    init(neurons:[Neuron]){
        self.neurons = neurons
    }
    
    init(inputSize:Int, outputSize:Int, activationFuction:Real->Real){
        self.neurons = (1...outputSize).map{ _ in Neuron(inputSize: inputSize, activationFuction) }
    }
    
    func activate(input:[Real])->[Real]{
        var output = [Real]()
        for neuron in neurons{
            output.append(neuron.activate(input))
        }
        return output
    }
}