//
//  main.swift
//  Neuronwork
//

var neuron = Neuron(inputSize:10, ActivationFunctions.sigmod)
var input = (1...10).map{n in Real(n)}
var activation = neuron.activate(input)
println(activation)

var layer = NeuronLayer(neurons: [neuron, neuron])
var output = layer.activate(input)
println(output)

var network = NeuronNetwork(layers: [layer, layer])
output = network.activate(input)
println(output)

var network2 = NeuronNetwork(layerSizes: [10, 5, 3], ActivationFunctions.sigmod)
output = network2.activate(input)
println(output)

var network3 = NeuralNetwork(layerSizes: [10, 5, 3], ActivationFunctions.sigmod)
output = network3.activate(input)
println(output)

var xorNetwork = NeuralNetwork(layerSizes: [2, 2, 1], ActivationFunctions.sigmod)
output = xorNetwork.activate([1,1])
println(output)

for i in 1...100 {
xorNetwork.train([([0,0],[0]),([0,1],[1]),([1,0],[1]),([1,1],[0])], eta: 4.0)
}
println(xorNetwork.activate([0,0]))
println(xorNetwork.activate([0,1]))
println(xorNetwork.activate([1,0]))
println(xorNetwork.activate([1,1]))

MnistData.train("/Users/Junfeng/Documents/SourceCode/", epochs: 2, miniBatchSize: 10, eta: 3.0)
