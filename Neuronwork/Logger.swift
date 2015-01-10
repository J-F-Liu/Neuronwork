import Foundation

class Logger{
    class func info(message:String){
        println("\(NSDate().description) \(message)")
    }
}