class Matrix{
    class func random(row:Int, col:Int) -> [[Real]]{
        var matrix = [[Real]]()
        for i in 1...row{
            matrix.append((1...col).map{_ in randomFloat()})
        }
        return matrix
    }
    
    class func add(v1:[Real], v2:[Real]) -> [Real]{
        var result = [Real]()
        for index in 0..<v1.count{
            result.append(v1[index] + v2[index])
        }
        return result
    }
    
    class func dot(v1:[Real], v2:[Real]) -> Real{
        var result = Real(0)
        for index in 0..<v1.count{
            result += v1[index] * v2[index]
        }
        return result
    }
    
    class func product(v1:[Real], v2:[Real]) -> [Real]{
        var result = [Real]()
        for index in 0..<v1.count{
            result.append(v1[index] * v2[index])
        }
        return result
    }
    
    class func multiply(matrix:[[Real]], vector:[Real]) -> [Real]{
        var result = [Real]()
        for row in matrix{
            result.append(dot(row, v2: vector))
        }
        return result
    }
    
    class func apply(vector:[Real], function:Real->Real) -> [Real]{
        var result = [Real]()
        for item in vector{
            result.append(function(item))
        }
        return result
    }
}