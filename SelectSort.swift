// This program reads information from file, 
// it then sorts using selection sort.

//
//  Created by Sarah Andrew

//  Created on 2023-20-5.

//  Version 1.0

//  Copyright (c) 2023 Melody. All rights reserved.
import Foundation

import Foundation

// This function calculates the mean.
func selectSort(_ arrayNum: [Int]) -> [Int] {
    var sortedNum = arrayNum
    // If statement, returning empty array 
    // to avoid out of bounds error. 
    if sortedNum.count < 2 {
        return sortedNum
    }
    // Usage of loop to access each element.
    for counter1 in 0..<sortedNum.count {
        // Declare variable. 
        var minNum = counter1;
        
        // This loop checks if current is bigger than
        // previous, switches positions if so, till sorted.
        for counter2 in (counter1 + 1)..<sortedNum.count {
            if sortedNum[counter2] < sortedNum[minNum] {
                minNum = counter2
            }
        }
        // Checking the min num in the loop.
        if minNum != counter1 {
            // Declare variable.
            let temp = sortedNum[counter1]
            // Using temp to swap.
            sortedNum[counter1] = sortedNum[minNum]
            sortedNum[minNum] = temp
        }
    
    }
    return sortedNum
}

// Define input & output paths.
let inputFile = "input.txt"
let outputFile = "output.txt"

// Usage of file handle method to locate files,
// as well as opening input for file reading.
do {
    // Open input file for reading.
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: cannot access input file for opening.")
        exit(1)
    }

    // Open output file for writing.
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: cannot access output file for opening.")
        exit(1)
    }

    // Read context for file.
    let inputData = input.readDataToEndOfFile()

    // Convert data to a string.
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert input data to string.")
        exit(1)
    }

    // Split string into lines, ensuring reading empty line
    // also creating list.
    let inputLines = inputString.components(separatedBy: .newlines)

    // Convert from string of list to array of integers
    // & check for blank lines.
    for line in inputLines {
        if line.isEmpty {
            let data4 = Data("No integers found on line.\n".utf8)
            output.write(data4)
            continue
        }
        
        var intArray: [Int] = []
        let numberStrings = line.components(separatedBy: " ")
        
        // Checking to see if array contains blank line.
        if numberStrings.isEmpty {
            let data5 = Data("No integers found on line.\n".utf8)
            output.write(data5)
            continue
        }

        // Convert from string to integer & check for invalid input.
        for str in numberStrings {
            if let intValue = Int(str) {
                intArray.append(intValue)
            } else {
                let data5 = Data("Invalid input: '\(str)' is not a valid integer\n".utf8)
                output.write(data5)
                break
            }
        }
        
        // Sort the integer array.
        let sortSelect = selectSort(intArray)
        
        // Write to file.
        let data3 = Data("The sorted array is:  \(sortSelect)\n".utf8)
        output.write(data3)
    }

    // Close input & output file.
    input.closeFile()
    output.closeFile()
}