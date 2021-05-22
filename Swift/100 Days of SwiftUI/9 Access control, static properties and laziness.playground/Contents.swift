import UIKit

// we can provide our own initializer for struct to override the default one the comes with the struct in swift

struct User {
    var username: String
    
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username

// note that swift removes the memberwise initializer if you create an initializer of your own

// to keep the default memberwise initializer while still defining our own, we can define an extension

struct Employee {
    var name: String
    var yearsActive = 0
}

extension Employee {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee()

// Referring to the current instance (and its properties)

// Person struct with a name property, then tried to write an initializer that accepted a name parameter, self helps you distinguish between the property and the parameter – self.name refers to the property, whereas name refers to the parameter.

struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name // this is actually where we're assigning the value name to the name (var) property of the struct
    }
}

// broadly speaking you don’t want to use the self keyword unless you specifically need to distinguish what you mean (between the property of the struct and the parameter of the initializer func)

// another example

struct Student {
    var name: String
    var bestFriend: String

    init(name: String, bestFriend: String) {
        print("Enrolling \(name) in class…")
        self.name = name
        self.bestFriend = bestFriend
    }
}

// we could also do this without self. ... but we'd have to use some sort of awkward prefix in front of our paramter values to distinguish them from struct properties

struct BadStudent {
    var name: String
    var bestFriend: String

    init(name studentName: String, bestFriend studentBestFriend: String) {
        print("Enrolling \(studentName) in class…")
        name = studentName
        bestFriend = studentBestFriend
    }
}

// As a performance optimization, Swift lets you create some properties only when they are needed.

struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

struct NewPerson {
    var name: String
    lazy var familyTree = FamilyTree()

    init(name: String) {
        self.name = name
    }
}

//  If we add the lazy keyword to the familyTree property, then Swift will only create the FamilyTree struct when it’s first accessed/used

var ed = NewPerson(name: "Ed")
ed.familyTree // now we need this line to acess the family tree struct (without it, the familyTree struct wouldn't be initialized)

// Swift’s lazy properties let us delay the creation of a property until it’s actually used, which makes them like a computed property. However, unlike a computed property they store the result that gets calculated, so that subsequent accesses to the property don’t redo the work. This allows them to provide extra performance when they aren’t used (because their code is never run), and extra performance when they are used repeatedly (because their value is cached.)


// All the properties and methods we’ve created so far have belonged to individual instances of structs. You can also ask Swift to share specific properties and methods across all instances of the struct by declaring them as static.

struct BetterStudent {
    static var classSize = 0  // a variable that belongs to the struct itself and not any specific instance
    var name: String

    init(name: String) {
        self.name = name
        BetterStudent.classSize += 1 // add a new student to the classSize when a new struct instance is initialized
    }
}

let me = BetterStudent(name: "Me")
let you = BetterStudent(name: "You")

// we need to access this static property using the struct name, rather than the name of a specific instance because it belongs to the struct itself

print(BetterStudent.classSize)

//Access control lets you restrict which code can use properties and methods.

struct PrivatePerson {
    private var id: String

    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
            return "My social security number is \(id)"
    }
}

var edward = PrivatePerson(id: "12345")

// now, because the id var is private, swift cannot access the id directly using the property syntax as usual. only methods inside the struct can access the private var

print(edward.identify())

// Another common option is public, which lets all other code use the property or method.

// Note that swift cannot create a memberwise initializer for us for structs with private properties (unless we provide stored values for the private variables) — actually unsure about this; the questions seemed to be inconsistant so will have to see what works when writing code






