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