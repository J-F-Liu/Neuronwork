class NeuronNetwork {
    
    var layers:[NeuronLayer]
    
    init(layers:[NeuronLayer]){
        self.layers = layers
    }
    
    init(layerSizes:[Int], activationFuction:Real->Real){
        var inputSize = layerSizes[0]
        self.layers = [NeuronLayer]()
        for index in 1..<layerSizes.count{
            var outputSize = layerSizes[index]
            var layer = NeuronLayer(inputSize: inputSize, outputSize: outputSize, activationFuction)
            self.layers.append(layer)
            inputSize = outputSize
        }
    }
    
    func activate(input:[Real])->[Real]{
        var activation = input
        for layer in layers{
            activation = layer.activate(activation)
        }
        return activation
    }
}