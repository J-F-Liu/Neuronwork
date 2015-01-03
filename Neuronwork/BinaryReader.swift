import Foundation

class BinaryReader{
    var fileData:NSData
    var location:Int
    
    init(filePath:String){
        self.fileData = NSData(contentsOfFile: filePath)!
        self.location = 0
    }
    
    func readBytes(count:Int)->[Byte]{
        if location >= fileData.length{
            return [Byte]()
        }
        var bytes = [Byte](count:count, repeatedValue:0)
        fileData.getBytes(&bytes, range:NSRange(location: location, length: count))
        location += count
        return bytes
    }
    
    func readUInt8() -> UInt8{
        var bytes = readBytes(1)
        return bytes[0]
    }
    
    func readInt32BE() -> Int32{
        var bytes = readBytes(4)
        var integer = Int32(0)
        for byte in bytes{
            integer <<= 8
            integer |= Int32(byte)
        }
        return integer
    }
}