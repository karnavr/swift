import UIKit

// creating basic closures

// Swift lets us use functions just like any other type such as strings and integers. This means you can create a function and assign it to a variable, call that function using that variable, and even pass that function into other functions as parameters.

let driving = {
    print("I'm driving my car!")
}

driving()

// closures accept parameters inside the open braces (the in keyword is there to mark the end of the parameter list and the start of the closure’s body itself.)

let drivingWithParameters = { (place: String) in
    print("I'm going to \(place) in my car")
}

// now we don't need parameter labels

drivingWithParameters("London")


// closures can also have return values

let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

// and we call it in a similar way to calling a function or previous closures

let message = drivingWithReturn("London")


// if we want to return a value from a closure that has no parameters, we still need to use the bracees where parameters would normally be declared

let payment = { () -> Bool in
    print("Paying an anonymous person…")
    return true
}

let paymentTest = payment // returns a true boolean


// using closures as parameters

// first let's start with the simple case where the closure returns nothing by using the driving closure (above) as an parameter to a new function

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

// note that the () -> Void tells the function that the closure accepts no parameters and also returns nothing

travel(action: driving)


// trailing closure syntax

// if the last parameter (or only) of our function is a closure, we may call travel like so:

travel() {
    print("I'm driving in my car") // this is the closure's body code which we are passing to the function as a parameter
}

// and because there aren’t any other parameters for this func, we can eliminate the parentheses entirely

travel {
    print("I'm driving in my car")
}


// using closures as parameters when they accept parameters

// this function accepts a closure as a parameter and we pass the parameter to the closure inside the func body
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

// now we can use trailing closure syntax to pass the closure itself to the func

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

// another example

func login(then action: (String) -> Void) {
    print("Authenticating...")
    let username = "karnavr"
    action(username)
}
login { (username: String) in
    print("Welcome, \(username)!")
}

// and another

func getMeasurement(handler: (Double) -> Void) {
    let measurement = 32.2
    handler(measurement)
}
getMeasurement { (measurement: Double) in
    print("It measures \(measurement).")
}


// Using closures as parameters when they return values

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car" // this is the code defining the "action" closure
}

// we can also massively shorten the closure paramter passing into the function like so (removing redundant info like "return", etc.)

travel {
    "I'm going to \($0) in my car"
}

// here's an example of when we would use a closure with a func, in this case we're reducing the values in an array passed in with an operation defined by our closure

func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    // start with a total equal to the first value
    var current = values[0]

    // loop over all the values in the array, counting from index 1 onwards
    for value in values[1...] {
        // call our closure with the current value and the array element, assigning its result to our current value
        current = closure(current, value)
    }

    // send back the final current value
    return current
}

let numbers = [10, 20, 30]

let sum = reduce(numbers) { (runningTotal: Int, next: Int) in
    return runningTotal + next
}

print(sum)

// Second, I mentioned previously that Swift’s operators are actually functions in their own right. For example, + is a function that accepts two numbers (e.g. 5 and 10) and returns another number (15).

// So, + takes two numbers and returns a number. And our reduce() function expects a closure that takes two numbers and returns a number. That’s the same thing! The + function fulfills the same contract as reduce() wants – it takes the same parameters and returns the same value.

// As a result, we can actually write this:

let sum2 = reduce(numbers, using: +)  // now this is SUPER neat


// another good example (you can change the algorithm) — however, one could also design funcs with if-else blocks for various algorithms so I suspect this isn't the main reason we use closures as parameters

func manipulate(numbers: [Int], using algorithm: (Int) -> Int) {
    for number in numbers {
        let result = algorithm(number)
        print("Manipulating \(number) produced \(result)")
    }
}

manipulate(numbers: [1, 2, 3]) { number in
    return number * number
}


// closures with multiple parameters

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

// we can call the function using shorhand parameter names and trailing closure syntax

travel {
    "I'm going to \($0) at \($1) miles per hour."
}

// Returning closures from functions

// in this case, the func returns a closure (accepting a string), which returns a string
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

// to retrive the closure, we can call the func as so, and then run the closure

let result = travel()
result("London")

// we can also get the return value from the closure directly in one line

let result2: Void = travel()("London")

// a closure can capture constants and variables from the surrounding context in which it’s defined

func travelIncrement() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

// Even though that counter variable was created inside travel(), it gets captured by the closure so it will still remain alive for that closure. So, if we call result("London") multiple times, the counter will go up and up:

let resultIncrement = travelIncrement()
resultIncrement("London")
resultIncrement("London")
resultIncrement("London")

// Put simply, value capturing takes place so that your closure always has access to the data it needs to work, which means Swift can run the closure safely. The value is maintained and the closure can access the value, after the original func call.

// As an example, let’s try writing a function that generates random numbers, but with a twist: it won’t return the same number twice in a row.

func makeRandomNumberGenerator() -> () -> Int {
    var previousNumber = 0
    
    return {
        var newNumber: Int
        
        repeat {
            newNumber = Int.random(in: 1...3)
        } while newNumber == previousNumber
        
        previousNumber = newNumber
        return newNumber
    }
}

// now test the func to see that it never returns the same number twice in a row

let generator = makeRandomNumberGenerator()

for _ in 1...10 {
    print(generator())
}

// this really shows how closure capturing matters and is useful

// try to make a function without closures that does this (a bit harder but might be easier in python haha), but again shows how much easier it is with closures

//func makeRandomNumberGen(quantity: Int, range: [Int]) -> [Int] {
//    var newNumber = [Int](repeating: 0, count: quantity)
//
//    for i in 1...quantity {
//        repeat {
//            newNumber[i] = Int.random(in: range[0]...range[1])
//        } while newNumber[i] == newNumber[i-1]
//    }
//
//    return newNumber
//}
//
//let randomNumbers = makeRandomNumberGen(quantity: 10, range: [0,10])

