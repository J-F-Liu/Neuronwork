extension NeuralNetwork{
    
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
        
        var layer = weightedInputs.count-1
        
        // delta of cross entropy cost
        var delta = Matrix.sub(activations[layer+1], v2: expected)
        
        nabla_weight_bias_pairs.insert(
            (Matrix.cross(delta, v2: activations[layer]), delta), atIndex: 0)
        
        layer--
        // propagate delta backward
        for (weight, _) in layers.reverse(){
            delta = Matrix.product(
                Matrix.multiply(Matrix.transpose(weight), vector: delta),
                v2: Matrix.apply(weightedInputs[layer], sigmodDerivative))
            nabla_weight_bias_pairs.insert(
                (Matrix.cross(delta, v2: activations[layer]), delta), atIndex: 0)
            if layer == 0{
                break
            }
            layer--
        }
        
        return nabla_weight_bias_pairs
    }
    
    func train(trainingSet:[([Real],[Real])], eta:Real, lambda:Real){
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
                Matrix.add(
                    Matrix.mul(1-eta*lambda/batchSize, matrix: weight),
                    m2: Matrix.mul(-eta/batchSize, matrix: nabla_weight)),
                Matrix.add(nabla_bias, v2: Matrix.mul(-eta/batchSize, vector: nabla_bias)))
        }
    }
}