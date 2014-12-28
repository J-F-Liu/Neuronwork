// matrix-based approach to computing the output from a neural network
class NeuralNetwork{
    var layers:[([[Real]],[Real])]
    var activationFuction:Real->Real
    
    init(layerSizes:[Int], activationFuction:Real->Real){
        var inputSize = layerSizes[0]
        self.layers = [([[Real]],[Real])]()
        for index in 1..<layerSizes.count{
            var outputSize = layerSizes[index]
            var weight = Matrix.random(outputSize, col: inputSize)
            var bias = (1...outputSize).map{_ in randomFloat()}
            //self.layers.append(weight, bias)
            self.layers += [(weight, bias)]
            inputSize = outputSize
        }
        self.activationFuction = activationFuction
    }
    
    func activate(input:[Real])->[Real]{
        var activation = input
        for (weight, bias) in layers{
            var weightedInput = Matrix.add(Matrix.multiply(weight, vector: activation), v2: bias)
            activation = Matrix.apply(weightedInput, activationFuction)
        }
        return activation
    }
}