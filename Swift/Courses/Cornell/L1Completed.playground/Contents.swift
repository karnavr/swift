import UIKit
//: ### Declaring Constants and Variables
/*
 In Swift, there's two "types" of variables:
 Let (constants) vs. Var (variables)
*/

let netid = "mml234" // this is immutable, once I assign a value to it, it can't be changed
var currentYear = 2018 // this can be changed!

// Let's try modifying them!
// netid = "yws3" (Can't do this, lets are constants and are immutable)
currentYear = 2019 // Since we used the var keyword to create this, the var is mutable

//: ### Type Annotations
var fullName: String = "Yana Sang"
var month: Int = 9
var label: UILabel = UILabel()

// What happens if we try assigning a different type to the variables?
// fullName = 2 (Warning: type int can't be type string)
// currentYear = "hello" (Even though we didn't specifiy the type when we created this variable, Swift infers the type based on the inital value you assign it)




//: ### Printing string and variables

// 1. Print a string
print("Hello world")
// 2. Print other types with string interpolation
print("The current year is \(currentYear)")




//: ### Arrays
// Two ways to initialize empty array
var lectureNumbers = [Int]()
var lectureNumbers2: [Int] = []

// Elements must match array type!
// lectureNumbers.append(1) -- this works
// lectureNumbers.append("one") -- this doesn't work, since "one" is a String and lectureNumbers is an Int array

// Add to an array with a for loop
for num in 1..<10 { // 1 - 9
    lectureNumbers.append(num)
}

for num in 1...10 { // 1 - 10
    lectureNumbers2.append(num)
}

for num in lectureNumbers {
    print(num)
}

for num in lectureNumbers2 {
    print(num)
}

// Remove from an array
print(lectureNumbers)
lectureNumbers.remove(at: 0)
// Array indexing starts at zero, so the element at index zero is the first number in the array
print(lectureNumbers)

// What if we remove from an empty array?
var lectureNumbers3: [Int] = []
lectureNumbers3.remove(at: 0) // Since the array is empty, we get an index out of range error at runtime

// Modify an array by indexing
var courseInstructors = ["Kevin", "Mindy"]
print(courseInstructors)
courseInstructors[0] = "Yana"
courseInstructors[1] = "Matthew"
print(courseInstructors)

// What if we go out of range?
// courseInstructors[2] = "Mathew" // Index out of range aggain!

// If you're trying to add to the end, use append!
courseInstructors.append("Mathew")
//: ### Dictionaries
// Dictionaries can be used to store key-value pairs

// Two ways to initialize empty dictionary
// The type of the key and type of the value don't have to be the same!
var pantry = [String: Int]()
var pantry2: [String: Int] = [:]

// Add key-value pair to the dictionary
pantry["apples"] = 2

// Modify a dictionary key-value pair
pantry["apples"] = 4

// Create dictionary with dictionary literal
pantry2 = ["apples": 10, "oranges": 5, "chocolate bars": 2]

// Iterate over dictionary with a for loop
for (food, quantity) in pantry2 {
    print("I have \(quantity) \(food).")
}





//: ### Functions

// Declare a function with no arguments
func printSomething() {
    print("something")
}
// If we run the playground to this point, will "something" be printed? -- No! We only declared the function

// Call a function
printSomething()

// Declare a function with arguments and a return type
// Need to name args and their types
// ex: add function that adds the two integers together and returns the sum
func add(a: Int, b: Int) -> Int {
    return a + b
}

// Call and Store the result of the function
let addTwoAndThree = add(a: 2, b: 3) // stores the result of calling add on 2 and 3 in the constant addTwoAndThree
print(addTwoAndThree)





//: ### Structs and Classes
// Struct Declaration
struct Episode {
    // properties of an Episode object
    var name: String
    var duration: Float
    // If you don't initialize the variable (i.e. assign it a value), you must specify the type
}

// Create some instances of our struct
// ex: episode1 named "Constants and Variables" with a duration of 10.0
var episode1 = Episode(name: "Constants and Variables", duration: 10.0)
// ex: episode2 named "Functions" with a duration of 12.0
var episode2 = Episode(name: "Functions", duration: 12.0)


// Class Declaration
class Podcast {
    var name: String
    var episodes: [Episode]

    // Must write an initializer if a class
    init(name: String, episodes: [Episode]) {
        self.name = name
        self.episodes = episodes
    }
    
    func playPodcast() {
        print("This episode is sponsored by \(name)")
    }
}

// Create an instance of Podcast
// ex: podcast named "Intro to iOS" which has the two episodes we created earlier
var podcast = Podcast(name: "Intro to iOS", episodes: [episode1, episode2])

// You can access properties with "dot notation" for both classes and structs
// ex: Print episode1's duration:
 print("episode1's duration is \(episode1.duration)")
// ex: Print podcast's name:
 print("podcast's name is \(podcast.name)")

/*
 Value Types (Structs) vs. Reference Types (Classes)
 */

// Value Types
// Assigning one struct instance to another struct instance (below, on line 186) creates a new copy of the struct. The two instances are NOT linked in any way, because structs are value types.
let episode3 = Episode(name: "Structs", duration: 5.0)
var episode4 = episode3

episode4.duration = 14.3

// Since we know episodes are structs...
// ...what is episode3.duration? -- 5.0
// ...what is episode4.duration? -- 14.3
print("Episode 3's duration is \(episode3.duration)")
print("Episode 4's duration is \(episode4.duration)")

// Episode 3's duration didn't change, since episode4 and episode3 refer to two DISTINCT objects in memory!

// Reference Types
// Assigning one class instance to another class instance (below, on line 201) causes the two instances to point to the same object/location in memory -- think of them like two labels for the same object.
let podcast2 = Podcast(name: "A New Podcast", episodes: [])
var podcast3 = podcast2
podcast3.name = "A Newer Podcast"

// Since we know podcasts are classes...
// ...what is Podcast2's name? -- A Newer Podcast
// ...what is Podcast3's name? -- A Newere Podcast
print("Podcast2's name is \(podcast2.name)")
print("Podcast3's name is \(podcast3.name)")

// Podcast2's name also changed because podcast2 and podcast3 are pointers to the same object!

/*
 In summary, Structs are VALUE types and Classes are REFERENCE types.
 This means that assigning one struct instance to another (as in line 186) creates a distinct copy of the struct and the two instances point to two DIFFERENT objects.
 On the other hand, when we assign on class instance to another (as in line 201), the two instances point to the SAME object. Thus, when we modify a property of one of the instances, the other one is modified as well.
 */




//: ### Optionals
/*
 Optional vs non-optional declaration
 */

// A non-optional value can't be nil!
var inputString = "Hello World!"
// If we try to assign nil to inputString...
// inputString = nil -- this doesn't compile because inputString is a non-optional var

// An optional value is allowed to be nil
var optionalString: String? = "Hello World!" // Denote an optional by adding a question mark after the type
optionalString = nil // we can assign nil to optionalString since it is an optional var

// Think of optional variables like a box. Once you open (or unwrap) the box, it could be empty (nil) or have some value inside


/*
 Unwrapping Optionals

 Unwrapping an optional means trying to access the value.
 Going back to the box analog, unwrapping is as if you're opening the box to see what's inside.
 */

// Unelegant way of checking for nil
if optionalString != nil {
    print("The string value wrapped in the optional is: \(optionalString)")
}

optionalString = nil
// Swifty way of checking for nil
// 1. If Let
if let unwrappedString = optionalString {
    print("The value wrapped in the optional string is: \(unwrappedString)")
}
// Since optionalString is nil, will "The value wrapped in the optional string is..." be printed? -- no!

optionalString = "Hello World!"
if let unwrappedString = optionalString {
    print("The value wrapped in the optional string is: \(unwrappedString)")
}
// What about now? -- it will be printed!

/*
 Note that with if lets, the unwrapped value (in the examples, the variable unwrappedString) is only accessible inside the if let statement, i.e. in between the { ... }.
 */

// 2. Guard Let
func unwrap(optionalString: String?) {
    guard let unwrappedString = optionalString else {
        print("guard let returns out of the function")
        return // You must return in the else statement of a guard let
    }
    print("Now I can use the unwrapped int which has a value of \(unwrappedString)")
}

unwrap(optionalString: nil) // Case 1, what will be printed? --> guard let returns...
unwrap(optionalString: "Hello world!") // Case 2, what will be printed? --> Now I can use...

/*
 Guard lets can be thought of as the opposite of an if let. One key difference is that the unwrapped value (in the examples, the variable unwrappedString) can be used outside the {...} following the guard let. In our example, we used unwrappedString on line 252, which is outside of the {} of the guard let.
 */

// 3. Nil Coalescing Operator (default value)
let unwrappedStringWithDefaultValue = optionalString ?? "default"

if unwrappedStringWithDefaultValue == "default" {
    print("unwrappedString was nil")
} else {
    print("unwrappedString value: \(unwrappedStringWithDefaultValue)")
}
// Since optionalString = "Hello World!", what will be printed? -- "unwrappedString value: Hello World!" is printed
// What if we go back and make optionalString = nil? -- "unwrappedString was nil" is printed

// 4. Force-Unwrapping (!) -- don't do this unless you are 110% certain that the optional value is NOT nil. If you force-unwrap a value is actually is nil, your app will crash.
var forceUnwrappedString: String? = "Hello World!"
print("I'm confident the optional has a value in it, it is: \(forceUnwrappedString!)")

forceUnwrappedString = nil
print("I'm SO CONFIDENT the optional has a value in it, but if it doesn't... \(forceUnwrappedString!)") // Unexpectedly found nil error at runtime! -- this will crash!

// Now, let's go back to dictionaries: how can we tell if a key is in a dictionary?
// The values returned are optionals!
// If the key doesn't exist, nil is returned
// If the key does exist, the value will be returned

// I have no pears in my pantry...
 print(pantry["pears"]!) // since I had no pears in my pantry, the value returned when I access the "value" for the key "pears" is nil, causing a "Unexpectedly found nil" error at runtime

// If we unwrap it...
if let value = pantry["pears"] {
    print("I have \(value) pears")
}
// What will print? -- Nothing!

// I have apples in my pantry...
if let value = pantry["apples"] {
    print("I have \(value) apples")
}
// What will print? -- I have 4 apples




//: ### Enums & case statements
// Enum declaration
enum FontSize {
    case small, medium, large
}

// Enum creation
let smallFontSize = FontSize.small
let mediumFontSize: FontSize = .medium
let largeFontSize: FontSize = .large

// Enums are great for switch statements!
func printFontSize(_ fontSize: FontSize) {
    // Switch statements must be exhaustive, so if you don't specify a case and don't provide a deafult case to "catch it", you'll get a compile-time error
    switch fontSize {
    case .small:
        print("I am small!")
    case .medium:
        print("I am medium!")
    case .large:
        print("I am large!")
//    case default:
//        print("IDK!")
    }
}

printFontSize(largeFontSize)
// What will print? --> "I am large!"

// What if we remove the .large case and add the default case instead? --> IDK!

