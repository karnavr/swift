import UIKit

var str = "Hello, playground"

//https://www.youtube.com/watch?v=iPZaNB88Eww&list=PLjf6nsEcF5KO2Eh6HmKztVRsBVDJ3x5qc

// Setting Variables and Constants

var netid = "kraval"

netid = "kraval3"

var fullName: String = "Karnav Raval"

var month: Int = 8

var label: UILabel = UILabel()


// Printing

print("Hello World")

print("Hi my name is \(fullName) and the current month is \(month)") //Sting interpolation



// Specifying variable type explicitly

var lectureNumbers = [Int]() //creates an instantace of an arrary of type Int
var lectureNumbers2: [Int] = []


// For Loop to append numbers

for i in 1...10 {
    lectureNumbers.append(i)
}

print(lectureNumbers)


// Modify array

var courseInstructors = ["Kevin", "Mindy"]
courseInstructors[1] = "Daniel"
print(courseInstructors)

courseInstructors.remove(at: 1)

print(courseInstructors)


//Dictionaries (Hashmaps in Java) — keys which match to values (not sorted/ordered in any way)

var pantry: [String: Int] = [:]

pantry["apples"] = 2 //adds an entry to the dictionary
pantry["apples"] = 4

pantry = ["apples": 5, "pears": 3, "oranges": 4] //can also create/add entries to dictionary by declaring them as so


// want to: interate through the pantry and print out statements for quantity of each fruit

for (food, quantity) in pantry {
    print("I have \(quantity) \(food)")
}


//Functions

func printHello() {
    print("Hello")
}

printHello()

func add(a: Int, b: Int) -> Int {
    return a + b
}

let addThreeAndFour = add(a: 3, b: 4)


//create a function with default values
func getPaperArea(width: Float = 8.5, height: Float = 11) -> Float {
    return width * height
}

let normalPaper = getPaperArea()
let weirdPaper = getPaperArea(width: 1, height: 200)
let otherPaper = getPaperArea(height: 14)


// functions do not need to have arguments or return types (if no return type specifified, it is returning Void) — need to do more learning
func printWithNoArgs(_ string: String) {
    
}


// Structs — a value-type representation of a class & Classes are a reference-type representation

struct Episode{
    var name: String
    var duration: Float
}

let episode1 = Episode(name: "Intro to iOS", duration: 60)

class Podcast {
    var name: String
    var episodes: [Episode]
    
    init(name: String, episodes: [Episode]){
        self.name = name
        self.episodes = episodes
    }
    
    func playPodcast() {
        print("This episode is sponsored by \(name)")
    }
}

let episode2 = Episode(name: "Classes and Structs", duration: 10)

let podcast = Podcast(name: "iOS Stuff", episodes: [episode1, episode2])

print("The name of this podcast is \(podcast.name)")
print("The duration of episode 1 is \(episode1.duration)")

var episode3 = episode2
episode3.name = "Structs"

// only episode 3's name will change and episode 2 will still retain all of it's original values, we have only been modifying episode 3's properties
print(episode2.name)
print(episode3.name)


var podcast2 = podcast

// We are copying in the podcast object into the variable podcast 2, and setting podcast 2's name to "Backend Stuff" and then print to see what happens

podcast2.name = "Backend Stuff"
print(podcast.name)
print(podcast2.name)

// Observe that both of them have been replaced by the new name because class objects pass references to the other object, so when we use an object to assign to another, the other one is also changed because it is still refering to the original

// Structs are value types so when you re-assign them all the values are copied over but not the object itself, but with classes the reference is maintained


//Optionals

var aRegularInt = 1

//somtimes, you can values that are nil or an actual value — you may have app labels (or somthing else) that sometimes shows up and other times doesn't, so optionals become ery handy

var optionalInt: Int? = 3

optionalInt = nil

//check if optionalInt is nil or not

//this works but there is a much swiftier and safer way to do this
if optionalInt != nil {
    print("The number isn't nill")
}

//use an if-let statment — assign a value to a variable only if that value is non-nil
//this safely unwraps the optional

if let unwrappedInt = optionalInt {
    print("The value inside is \(unwrappedInt)")
} else {
    print("optionalInt was nil")
}

//note that the upwrappedInt var cannot be called outside the above block

print("The values inside is \(optionalInt ?? 0)") // print optionalInt if it is not nil, otherwise print 0


//optionals can also be used with dicts

if let numPears = pantry["pears"] {
    print("I have \(numPears) pears")
}


//Enums — used when you want to denotes cases but intergers or floats may not be the most clear way to do this

enum Size {
    case small, medium, large // 3 sizes in size enum
}

let smallFontSize = Size.small
let medFontSize: Size = .medium

//want to creaate a function that takes in a size and prints something different based on what size it gets

func printFontSize(size: Size) {
    switch size {
    case .small:
        print("I'm small")
    case .medium:
        print("I'm large")
    case .large:
        print("I'm large")
    }
}

printFontSize(size: .large)

// we can also specify a default case using "default:" instead of "case .small"


// the lecture contiues with an overview of the xcode interface



