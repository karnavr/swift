import UIKit

// Classes are similar to structs in that they allow you to create new types with properties and methods. But..

// 1. They don't come with a memberwise initializer. We need to write our own

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")

// 2. Class inheritance

// the class you inherit from is called the “parent” or “super” class, and the new class is called the “child” class. We can create a new Poodle class based on the Dog class, and we can optionally create a new initializer for the Poodle class.

class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }

}

// For safety reasons, Swift always makes you call super.init() from child classes – just in case the parent class does some important work when it’s created.

// the main reason that classes don't come with memberwise initializers is actually because they have inheritance. Think about it: if I built a class that you inherited from, then added some properties to my class later on, your code would break – all those places you relied on my memberwise initializer would suddenly no longer work.

// 3. Over-riding

// Child classes can replace parent methods with their own implementations – a process known as overriding.

class Doggo {
    func makeNoise() {
        print("Woof!")
    }
}

class PoodleNoise: Doggo {
    override func makeNoise() {
        print("Yip!")
    }
}

let poppyNoise = PoodleNoise()
poppyNoise.makeNoise()

// Swift gives us a final keyword: you declare a class as being final, no other class can inherit from it.

final class FinalDog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// 4. Copying classes - when a class is copied, both the original and the copied point to the same thing (unlike structs, which creates a new object)

class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"  // changing the name of the copy class

// the original singer will now say justin bieber
print(singer.name)

// this means that structs are value types and classes are reference types (https://www.hackingwithswift.com/quick-start/understanding-swift/why-do-copies-of-a-class-share-their-data)

// As with many things in programming, the choices you make should help convey a little of your reasoning. In this case, using a class rather than a struct sends a strong message that you want the data to be shared somehow, rather than having lots of distinct copies.


// 5. De-initializers

// this is code that gets run when an instance of a class is destroyed.

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

// now we will get the deinit message everytime the person constant is rewritten to another class (when the class instance is destroyed)


// 6. Mutability

// The final difference between classes and structs is the way they deal with constants. If you have a constant struct with a variable property, that property can’t be changed because the struct itself is constant. However, if you have a constant class with a variable property, that property can be changed. Because of this, classes don’t need the mutating keyword with methods that change properties; that’s only needed with structs.

class Singerr {
    var name = "Taylor Swift"
}

let taylor = Singerr()
taylor.name = "Ed Sheeran" // we can change the classes name property even though instance is a constant
print(taylor.name)

// If you want to stop that from happening you need to make the property constant.










