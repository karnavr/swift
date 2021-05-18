import UIKit

// swift lets us create custom types of using structs (and classes), with several fundamental types. For example, you might put three strings and a boolean together and say that represents a user in your app.

struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name) // this is how properties inside structs are accessed


// we can also define computed properties; properties which are computed inside the struct based on the other, stored properties

struct OlyimpicSport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = OlyimpicSport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

// computed properties are values which are recomputed every time it’s called. Behind the scenes, a computed property is effectively just a function call that happens to belong to your struct.

// note that constants cannot be computed properties and computed properties must always have an explicit type

// Property observers let you run code before or after any property changes. To demonstrate this, we’ll write a Progress struct that tracks a task and a completion percentage:

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

// now let's create an instance of the struct and adjust/increment it's progress over time

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

// You can also use willSet to take action before a property changes, but that is rarely used.

// Most of the time property observers aren’t required, just nice to have – we could just update a property normally then call a function ourselves in code. So why bother? When would you actually use property observers? he most important reason is convenience: using a property observer means your functionality will be executed whenever the property changes. Sure, you could use a function to do that, but would you remember? Always? In every place you change the property?

// note that we cannot attach a property observer to a constant, because it will never change.

struct Student {
    var name: String
    var debt: Int {
        didSet {
            if debt < 5_000 {
                print("This is great!")
            } else if debt < 20_000 {
                print("This is OK.")
            } else {
                print("Can I fake my own death?")
            }
        }
    }
}


// Methods: Structs can have functions inside them, and those functions can use the properties of the struct as they need to. Functions inside structs are called methods, but they still use the same func keyword.

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

// the only real difference between functions and methods is that methods belong to a type, such as structs, enums, and classes, whereas functions do not.

// being associated with a specific type such as a struct means that methods gain one important super power: they can refer to the other properties and methods inside that type. methods also methods avoid namespace pollution. Whenever we create a function, the name of that function starts to have meaning in our code. That can get messy quickly, but by putting functionality into methods we restrict where those names are available. This reduces the so-called pollution, because if most of our code is in methods then we won’t get name clashes by accident.

// note that if the func has parameters, they are passed when the method is called

struct Venue {
    var name: String
    var maximumCapacity: Int
    func makeBooking(for people: Int) {
        if people > maximumCapacity {
            print("Sorry, we can only accommodate \(maximumCapacity).")
        } else {
            print("\(name) is all yours!")
        }
    }
}

let venue = Venue(name: "my big stadium", maximumCapacity: 200)
venue.makeBooking(for: 199)


// If a struct has a variable property but the instance of the struct was created as a constant, that property can’t be changed – the struct is constant, so all its properties are also constant regardless of how they were created.

//The problem is that when you create the struct Swift has no idea whether you will use it with constants or variables, so by default it takes the safe approach: Swift won’t let you write methods that change properties unless you specifically request it. If we want to change a property inside a struct, we need to mark it using the mutating keyword

struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed") // note that Person instances still need to be variables for the method to actually change the property
person.makeAnonymous()

// Surprise! Turns out strings are structs with a bunch of methods, give it a try!

let string = "Do or do not, there is no try."

string.count
string.hasPrefix("Do")
string.uppercased()
string.sorted()

// Almost all of Swift’s core types are implemented as structs, including strings, integers, arrays, dictionaries, and even Booleans. This isn’t an accident: structs are simple, fast, and efficient in Swift, which means we can create and destroy them as much as we need without worrying too much about performance.

// see https://www.hackingwithswift.com/quick-start/understanding-swift/why-are-strings-structs-in-swift for more info on why strings are structs (quite interesting!)

// arrays are also structs! let's try out some of their methods.

var toys = ["Woody"]

toys.count
toys.append("Buzz") // see how this is a mutating property?
toys.firstIndex(of: "Buzz")
toys.sorted()
toys.remove(at: 0)



