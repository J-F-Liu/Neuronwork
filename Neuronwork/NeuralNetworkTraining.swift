extension NeuralNetwork{
    
    func costDerivative(activation:[Real], expectedOutput:[Real])->[Real]{
        var diff = [Real](count:activation.count, repeatedValue:0)
        for i in 0..<activation.count{
            diff[i] = activation[i] - expectedOutput[i]
        }
        return diff
    }
    
    func backPropagation(input:[Real], expected:[Real]) -> [([[Real]],[Real])]{
        var nabla_weight_bias_pairs = [([[Real]],[Real])]()
        var activation = input
        var activations = [[Real]]()
        var weightedInputs = [[Real]]()
        activations.append(activation)
        
        // feed forward
        for (weight, bias) in layers{
            var weightedInput = Matrix.add(Matrix.multiply(weight, vector: activation), v2: bias)
            weightedInputs.append(weightedInput)
            
            activation = Matrix.apply(weightedInput, ActivationFunctions.sigmod)
            activations.append(activation)
        }
        
        var delta = Matrix.product(
            costDerivative(activations[activations.count-1], expectedOutput: expected),
            v2: Matrix.apply(weightedInputs[weightedInputs.count-1], sigmodDerivative))
        
        nabla_weight_bias_pairs.insert(
            (Matrix.cross(delta, v2: activations[activations.count-2]), delta), atIndex: 0)
        
        var l = 2
        // propagate delta backward
        for (weight, _) in layers.reverse(){
            delta = Matrix.product(
                Matrix.multiply(Matrix.transpose(weight), vector: delta),
                v2: Matrix.apply(weightedInputs[weightedInputs.count-l], sigmodDerivative))
            nabla_weight_bias_pairs.insert(
                (Matrix.cross(delta, v2: activations[activations.count-l-1]), delta), atIndex: 0)
            if l == weightedInputs.count{
                break
            }
            l++
        }
        
        return nabla_weight_bias_pairs
    }
    
    func train(trainingSet:[([Real],[Real])], eta:Real){
        var nabla_weight_bias_pairs = layers.map{(weight, bias) in
            (Matrix.zeros(weight.count, col: weight[0].count), bias.map{_ in Real(0)})}
        for (input, target) in trainingSet{
            var delta_weight_bias_pairs = backPropagation(input, expected: target)
            for index in 0..<layers.count {
                var (delta_weight, delta_bias) = delta_weight_bias_pairs[index]
                var (nabla_weight, nabla_bias) = nabla_weight_bias_pairs[index]
                nabla_weight_bias_pairs[index] = (
                    Matrix.add(nabla_weight, m2: delta_weight), Matrix.add(nabla_bias, v2: delta_bias))
            }
        }
        var batchSize = Real(trainingSet.count)
        for index in 0..<layers.count {
            var (weight, bias) = layers[index]
            var (nabla_weight, nabla_bias) = nabla_weight_bias_pairs[index]
            layers[index] = (
                Matrix.add(weight, m2: Matrix.mul(-eta/batchSize, matrix: nabla_weight)),
                Matrix.add(nabla_bias, v2: Matrix.mul(-eta/batchSize, vector: nabla_bias)))
        }
    }
}