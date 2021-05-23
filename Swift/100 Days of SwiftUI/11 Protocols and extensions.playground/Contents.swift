import UIKit

// Protocols

// Protocols are a way of describing what properties and methods something must have. You then tell Swift which types use that protocol – a process known as adopting or conforming to a protocol.

// see: https://www.hackingwithswift.com/quick-start/understanding-swift/why-does-swift-need-protocols

// this is an protocol with name "Identifiable" that defines an "id" property can may be read or written (get set)

protocol Identifiable {
    var id: String { get set }
}

//We can’t create instances of that protocol - it’s a description of what we want, rather than something we can create and use directly. But we can create a struct that conforms to it:

struct User: Identifiable {
    var id: String
}

// Finally, we’ll write a displayID() function that accepts any Identifiable object:

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

// Protocol inheritance

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

// We can now create a single Employee protocol that brings them together in one protocol. We don’t need to add anything on top, so we’ll just write open and close braces:

protocol Employee: Payable, NeedsTraining, HasVacation { }

// Now we can make new types conform to that single protocol rather than each of the three individual ones.

// GREAT examples for when to use protocol inheritance: https://www.hackingwithswift.com/quick-start/understanding-swift/when-should-we-use-protocol-inheritance


// Extensions

// Extensions allow you to add methods to existing types, to make them do things they weren’t originally designed to do.

// For example, we could add an extension to the built-in "Int" type so that it has a squared() method that returns the current number multiplied by itself

extension Int {
    func squared() -> Int {
        return self * self
    }
}

// Now any instance of the Int type we create now has a squared() method:

let number = 8
number.squared()

// Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead. For example, we could add a new isEven computed property to integers that returns true if it holds an even number:

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

// Protocol extensions

// Protocol extensions are like regular extensions, except rather than extending a specific type like Int you extend a whole protocol so that all conforming types get your changes. Protocol extensions extend the functionality of all types conforming to a protocol

// for example, here is an array and a set containing names

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

// Swift’s arrays and sets both conform to a protocol called Collection, so we can write an extension to that protocol to add a summarize() method to print the collection neatly

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

// Both Array and Set will now have that method, so we can try it out:

pythons.summarize()
beatles.summarize()

// we use protocol extensions to add functionality directly to protocols, which means we don’t need to copy that functionality across many structs and classes.

// another example, again showing the power of this "protocol-oriented programming"

protocol Identifiable2 {
    var id: String { get set }
    func identify()
}

// We could make every conforming type write their own identify() method, but protocol extensions allow us to provide a default:

extension Identifiable2 {
    func identify() {
        print("My ID is \(id).")
    }
}

// Now when we create a type that conforms to Identifiable it gets identify() automatically:

struct User2: Identifiable2 {
    var id: String
}

let twostraws = User2(id: "twostraws")
twostraws.identify()

// Summary

// Protocols describe what methods and properties a conforming type must have, but don’t provide the implementations of those methods.
// You can build protocols on top of other protocols, similar to classes.
// Extensions let you add methods and computed properties to specific types such as Int.
// Protocol extensions let you add methods and computed properties to protocols.
// Protocol-oriented programming is the practice of designing your app architecture as a series of protocols, then using protocol extensions to provide default method implementations.

