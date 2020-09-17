import Foundation

var width: Float = 2.5
var height: Float = 2.3
let areaPerBucket:Float = 2.5

var numOfBuckets:Int {
    get {
        return Int (ceil ((width*height)/areaPerBucket))
    }
    set {
        let areaCovered = Float(newValue)*areaPerBucket
        print("Area covered : \(areaCovered)")
    }
}

print(numOfBuckets)

numOfBuckets = 3
