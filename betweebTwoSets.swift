import Foundation

/*
 * Complete the 'getTotalX' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER_ARRAY a
 *  2. INTEGER_ARRAY b
 */

func getTotalX(a: [Int], b: [Int]) -> Int {
    let aMin = a.min()!
    let aMax = a.max()!
    let bMin = b.min()!
    var count = 0
    var numbersToCheck: [Int] = []

    var num = aMin

    // Add multiples of smallest number in first array
    while(num<=bMin) {
        if !numbersToCheck.contains(num) && num >= aMax {
            numbersToCheck.append(num)
        }
        num += aMin
    }
    // Remove numbers that do not factor by all in first array
    for i in numbersToCheck {
        for j in a {
            if i%j != 0 {
                let index = numbersToCheck.index(of: i)!
                numbersToCheck.remove(at: index)
                break
            }
        }
    }

    // Check against second array
    for n in numbersToCheck {

        var match: Bool = true
        for j in b {
            if j%n != 0 {
                match = false
                break
            }
        }
        if match == true {
            count += 1
        }
    }

    return count

}

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let firstMultipleInputTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }
let firstMultipleInput = firstMultipleInputTemp.split(separator: " ").map{ String($0) }

guard let n = Int(firstMultipleInput[0])
else { fatalError("Bad input") }

guard let m = Int(firstMultipleInput[1])
else { fatalError("Bad input") }

guard let arrTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let arr: [Int] = arrTemp.split(separator: " ").map {
    if let arrItem = Int($0) {
        return arrItem
    } else { fatalError("Bad input") }
}

guard arr.count == n else { fatalError("Bad input") }

guard let brrTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let brr: [Int] = brrTemp.split(separator: " ").map {
    if let brrItem = Int($0) {
        return brrItem
    } else { fatalError("Bad input") }
}

guard brr.count == m else { fatalError("Bad input") }

let total = getTotalX(a: arr, b: brr)

fileHandle.write(String(total).data(using: .utf8)!)
fileHandle.write("\n".data(using: .utf8)!)
