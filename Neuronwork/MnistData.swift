import Foundation

class MnistData{
    class func load(imageDataFile:String, labelDataFile:String)->[([Real],[Real])]{
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
        
        var images = [([Real],[Real])]()
        for i in 0..<count{
            var input = imageReader.readBytes(imageSize).map{byte in Real(byte)}
            var target = vectorized_target(labelReader.readUInt8())
            images.append((input, target))
        }
        return images
    }
    
    class func vectorized_target(number:UInt8)->[Real]{
        var vector = [Real](count: 10, repeatedValue:0)
        vector[Int(number)] = 1
        return vector
    }
    
    class func train(dataFolder:String, epochs:Int, miniBatchSize:Int, eta:Real){
        println("\(NSDate().description) load training data")
        var traingData = load(dataFolder+"train-images-idx3-ubyte",
            labelDataFile: dataFolder+"train-labels-idx1-ubyte")
        
        println("\(NSDate().description) load test data")
        var testData = load(dataFolder+"t10k-images-idx3-ubyte",
            labelDataFile: dataFolder+"t10k-labels-idx1-ubyte")
        
        println("\(NSDate().description) initialize nueral network")
        var network = NeuralNetwork(layerSizes: [784, 100, 10], ActivationFunctions.sigmod)
        
        println("\(NSDate().description) start training")
        for epoch in 0..<epochs{
            for var k=0; k<5000; k+=miniBatchSize{
                var trainingSet = [([Real],[Real])](traingData[k..<k+miniBatchSize])
                network.train(trainingSet, eta:eta)
            }
            
            var testResult = testData[0..<1000].map{ (input,target) in self.evaluate(network, input: input, target: target)}
            
            println("\(NSDate().description) Epoch \(epoch), \(testResult.reduce(0){ $0 + $1 })/1000")
        }
    }
    
    class func evaluate(network:NeuralNetwork, input:[Real], target:[Real]) -> Int{
        var activation = network.activate(input)
        return Matrix.maxIndex(activation) == Matrix.maxIndex(target) ? 1 : 0
    }
}