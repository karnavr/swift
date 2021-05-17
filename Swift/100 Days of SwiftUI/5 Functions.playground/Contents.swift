import UIKit

// Always need to define an enum to deal with error cases

enum AgeError: Error {
    case underAge
    case unknownAge
}

// need the "throws" keyword in a function that throws an error

func buyAlcohol(age: Int) throws {
    if age >= 18 {
        print("OK.")
    } else {
        throw AgeError.underAge
    }
}

// running the function that potentially throws an error

do {
    try buyAlcohol(age: 21)
    print("Here's your alcohol fine sir/madam!")
} catch {
    print("You're too young to buy alcohol!")
}

// inout parameters in functions

var myNum = 10

// this is how I normally define functions, the value returned must be assigned to a new object
func squareNum (num: Int) -> Int {
    return num*num
}

let functest = squareNum(num: myNum)

// in swift we can also change the variable (cannot be a constant) passed into the function itself

func squareNumInPlace (num: inout Int) {
    num *= num
}

var myNumInPlace = 12
print("myNumInPlace is currently \(myNumInPlace)")
squareNumInPlace(num: &myNumInPlace)
print("myNumInPlace is now \(myNumInPlace)")

// note to self: not sure how useful inout functions are (noting that swift operators *= and += are defined this way), given that it's usually better to return a new value for cleaner code logic and generality of functions. But perhaps it's useful sometimes while designing apps with some temporary variable..
