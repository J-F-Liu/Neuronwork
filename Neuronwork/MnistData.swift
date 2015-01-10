import Foundation

// MNIST Website http://yann.lecun.com/exdb/mnist/
class MnistData{
    class func load(imageDataFile:String, labelDataFile:String)->[([Real],UInt8)]{
        var imageReader = BinaryReader(filePath: imageDataFile)
        var id = imageReader.readInt32BE()
        assert(id == 2051, "Invalid image data file")
        var count = imageReader.readInt32BE()
        var rows = imageReader.readInt32BE()
        var cols = imageReader.readInt32BE()
        var imageSize = Int(rows * cols)
        
        var labelReader = BinaryReader(filePath: labelDataFile)
        id = labelReader.readInt32BE()
        assert(id == 2049, "Invalid label data file")
        var labelCount = labelReader.readInt32BE()
        assert(count == labelCount, "Image count and label count mismatch.")
        
        var images = [([Real],UInt8)]()
        for i in 0..<count{
            var input = imageReader.readBytes(imageSize).map{byte in Real(byte)/Real(Byte.max)}
            var target = labelReader.readUInt8()
            images.append((input, target))
        }
        return images
    }
    
    class func vectorized_target(number:UInt8)->[Real]{
        var vector = [Real](count: 10, repeatedValue:0)
        vector[Int(number)] = 1
        return vector
    }
    
    class func train(dataFolder:String, epochs:Int, miniBatchSize:Int, eta:Real, lambda:Real){
        Logger.info("load training data")
        var traingData = load(dataFolder+"train-images-idx3-ubyte",
            labelDataFile: dataFolder+"train-labels-idx1-ubyte")
        
        Logger.info("load test data")
        var testData = load(dataFolder+"t10k-images-idx3-ubyte",
            labelDataFile: dataFolder+"t10k-labels-idx1-ubyte")
        
        Logger.info("initialize nueral network")
        var network = NeuralNetwork(layerSizes: [784, 30, 10], ActivationFunctions.sigmod)
        
        Logger.info("start training")
        for epoch in 0..<epochs{
            for var k=0; k<1000; k+=miniBatchSize{
                var trainingSet = traingData[k..<k+miniBatchSize].map{ (input,target) in (input, self.vectorized_target(target)) }
                network.train([([Real],[Real])](trainingSet), eta:eta, lambda:lambda)
            }
            
            Logger.info("run test")
            var testResult = testData[0..<1000].map{ (input,target) in self.evaluate(network, input: input, target: target)}
            
            Logger.info("Epoch \(epoch), \(testResult.reduce(0){ $0 + $1 })/1000")
        }
    }
    
    class func evaluate(network:NeuralNetwork, input:[Real], target:UInt8) -> Int{
        var activation = network.activate(input)
        return Matrix.maxIndex(activation) == Int(target) ? 1 : 0
    }
}