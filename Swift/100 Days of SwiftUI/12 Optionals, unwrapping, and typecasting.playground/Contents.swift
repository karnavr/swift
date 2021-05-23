import UIKit

// Optionals - swift's solution to solving the problem of "what if a variable type may not have a value?", they let us represent the absence of some data (a string that isn’t just empty, but literally doesn’t exist)

// an optional age variable of type optional Int
var age: Int? = nil

// optionals may be any type - even custum defined types in swift; a User struct could have it's properties defined, or could all be nil, this would require a variable with type optional User



// Unwrapping optionals

// it is unsafe to assume that an optional has a value in it, so we use if let - else blocks to check and run code accordingly to unwrap the optional only if it has an associated value (i.e. not nil)

var name: String? = nil

if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("missing name.")
}

// observe that we bind the optional value (if there is one) to a new unwrapped name and then the code in the if block uses the new unwrapped variable name


// Using gaurd to unwrap

// An alternative to if let is guard let, which also unwraps optionals. guard let will unwrap an optional for you, but if it finds nil inside it expects you to exit the function, loop, or condition you used it in. However, the major difference between if let and guard let is that your unwrapped optional remains usable after the guard code.

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}

// Because optionals unwrapped using guard let stay around after the guard finishes, we can print the unwrapped string at the end of the function

// Using guard let lets you deal with problems at the start of your functions, then exit immediately. This means the rest of your function is the happy path – the path your code takes if everything is correct.

// when to use if-let vs. guard-let: https://www.hackingwithswift.com/quick-start/understanding-swift/when-to-use-guard-let-rather-than-if-let

// So, use if let if you just want to unwrap some optionals, but prefer guard let if you’re specifically checking that conditions are correct before continuing.



// Force unwrapping - if we're sure that it's safe to un-wrap an optional, we may force up-wrap it like so

let str = "5"
let num = Int(str)!

print(type(of: num))

// now num will be a normal Int (due to the !), otherwise the num constant will be created as an optional Int

// As a result, you should force unwrap only when you’re sure it’s safe – there’s a reason it’s often called the crash operator. That’s the key here: you should never force unwrap something that won’t succeed 100% of the time. That’s it – that’s the entire rule.


// Implicitly unwrapped optionals - these optionals behave as if they are already un-wrapped, so we don't need to use if-let or guard-let statements to un-wrap them safely. They are used when some var starts it's life as a nil but we know that it will for sure have a value by the time we need to use it.

var myAge: Int! = nil

// That being said, if you’re able to use regular optionals instead it’s generally a good idea.



// Nil coalescing

// The nil coalescing operator unwraps an optional and returns the value inside if there is one. If there isn’t a value – if the optional was nil – then a default value is used instead. Either way, the result won’t be optional: it will either by the value from inside the optional or the default value used as a back up.

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

//If we call that with ID 15 we’ll get back nil because the user isn’t recognized, but with nil coalescing we can provide a default value of “Anonymous” like this:

let user = username(for: 15) ?? "Anonymous"

// if the output from the func (which returns an optional string) is a string then it will be unwrapped and placed into user, but if it has nil inside then “Anonymous” will be used instead.



// Optional chaining

// Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is optional, you can write a question mark after it to enable optional chaining: a.b?.c. When that code is run, Swift will check whether b has a value, and if it’s nil the rest of the line will be ignored – Swift will return nil immediately. But if it has a value, it will be unwrapped and execution will continue.

let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()

// observe that if there is no elements in the array, the .first property (which is a computed property) will return nil and the execution will be terminated at that point (beatle will be set to nil), swift will not run the .uppercased method

// Swift’s optional chaining lets us dig through several layers of optionals in a single line of code, and if any one of those layers is nil then the whole line becomes nil.

// we can also pair this with nil coalescing:

let beatleName = names.first?.uppercased() ?? "?"

// recall the following func that throws an error is the password is obvious

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// now we can get the same behaviour using an optional try statement

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

// this try? returns a nil if the func throws an error, otherwise you’ll get the return value wrapped as an optional.

// The other alternative is try!, which you can use when you know for sure that the function will not fail. If the function does throw an error, your code will crash.

try! checkPassword("sekrit")
print("OK!")

// see: https://www.hackingwithswift.com/quick-start/understanding-swift/when-should-you-use-optional-try for when we would use do, try and catch and when we would use the optional try?



// Failable initializers - we can create a falible initializer that returns an optional type depending on the value that the instance of the struct was initialized with:

struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

// the init? tells swift to return an optional - observe that there must be a return nil statement for some case in our init?()

let aPerson = Person(id: "123456789")
print(type(of: aPerson))

// we use such initializers if an initializer for a struct or class can fail – if you realize part-way through that you cannot create the object using the data you were provided – then you need a failable initializer. Rather than returning a new object instance, this returns an optional instance that will be nil if initialization failed.

// here's another falible initializer with two checks:

struct Employee {
    var username: String
    var password: String

    init?(username: String, password: String) {
        guard password.count >= 8 else { return nil }
        guard password.lowercased() != "password" else { return nil }

        self.username = username
        self.password = password
    }
}

// this requires passwords be at least 8 characters and not be the string “password”.

// Yes, you could absolutely put these checks into a separate method, but it’s much safer to put them into the initializer – it’s too easy to forget to call the other method, and there’s no point leaving that hole open.


// Typecasting

// here are 2 arrays (Fish and Dog) that inherit from the Animal class

class Animal { }

class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(), Dog(), Fish(), Dog()]

// Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array of Animal. If we want to loop over the pets array and ask all the dogs to bark, we need to perform a typecast: Swift will check to see whether each pet is a Dog object, and if it is we can then call makeNoise().

// to do this we use the new keyword as? which returns an optional: it will be nil if the typecast failed, or a converted type otherwise.

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

// Type casting lets us tell Swift that an object it thinks is type A is actually type B, which is helpful when working with protocols and class inheritance. another great example: https://www.hackingwithswift.com/quick-start/understanding-swift/when-is-type-casting-useful-in-swift








