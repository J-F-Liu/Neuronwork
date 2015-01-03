class Matrix{
    class func zeros(row:Int, col:Int) -> [[Real]]{
        var matrix = [[Real]]()
        for i in 1...row{
            matrix.append((1...col).map{_ in Real(0)})
        }
        return matrix
    }
    class func random(row:Int, col:Int) -> [[Real]]{
        var matrix = [[Real]]()
        for i in 1...row{
            matrix.append((1...col).map{_ in randomFloat()-0.5})
        }
        return matrix
    }
    
    class func mul(factor:Real, vector:[Real]) -> [Real]{
        return vector.map{item in factor*item}
    }
    
    class func mul(factor:Real, matrix:[[Real]]) -> [[Real]]{
        return matrix.map{row in self.mul(factor,vector: row)}
    }
    
    class func add(v1:[Real], v2:[Real]) -> [Real]{
        var result = [Real]()
        for index in 0..<v1.count{
            result.append(v1[index] + v2[index])
        }
        return result
    }
    
    class func add(m1:[[Real]], m2:[[Real]]) -> [[Real]]{
        var result = [[Real]]()
        for index in 0..<m1.count{
            result.append(self.add(m1[index], v2: m2[index]))
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
    
    class func cross(v1:[Real], v2:[Real]) -> [[Real]]{
        return v1.map{ item in self.mul(item, vector: v2)}
    }
    
    class func multiply(matrix:[[Real]], vector:[Real]) -> [Real]{
        var result = [Real]()
        for row in matrix{
            result.append(dot(row, v2: vector))
        }
        return result
    }
    
    class func transpose(matrix:[[Real]])->[[Real]]{
        var result = [[Real]]()
        var columns = matrix[0].count
        for col in 0..<columns{
            result.append(matrix.map{row in row[col]})
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
    
    class func maxIndex(vector:[Real])->Int{
        var maxValue = vector[0]
        var maxIndex = 0
        for var index = 1; index < vector.count; index++ {
            if vector[index] > maxValue{
                maxIndex = index
            }
        }
        return maxIndex
    }
}