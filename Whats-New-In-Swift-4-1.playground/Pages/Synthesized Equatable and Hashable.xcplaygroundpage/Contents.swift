/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Synthesized `Equatable` and `Hashable`

 The `Equatable` protocol allows Swift to compare one instance of a type against another. When we say 5 == 5, Swift understands what that means because `Int` conforms to `Equatable`, which means it implements a function describing what `==` means for two instances of `Int`.

 Implementing `Equatable` in our own value types allows them to work like Swift’s strings, arrays, numbers, and more, and it’s usually a good idea to make your structs conform to `Equatable` just so they fit the concept of value types better.

 Swift 4.1 implements [SE-0185](https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md), which allows the compiler to synthesize conformance for `Equatable` – it can generate an `==` method automatically, which will compare all properties in one value with all properties in another.

 All you have to do is add `Equatable` to your type, and Swift can take care of the rest. For example:
 */
struct Person: Equatable {
   var firstName: String
   var lastName: String
   var age: Int
}

let paul = Person(firstName: "Paul", lastName: "Hudson", age: 38)
let joanne = Person(firstName: "Joanne", lastName: "Rowling", age: 52)

if paul == joanne {
   print("These people match")
} else {
   print("No match")
}
/*:
 Of course, if you *want* you can implement `==` yourself. For example, if your type has an `id` property that identifies it uniquely, you would write `==` to compare that single value rather than letting Swift do all the extra work of comparing all properties.

 In this next example, each instance of `User` has a variety of properties that the default implementation of `==` would have to compare in order to check whether two objects are equal. However, by adding our own `==` implementation we can check a property we know is unique:
 */
struct User: Equatable {
   var id: Int
   var username: String
   var password: String
   var jobTitle: String
   var firstName: String
   var lastName: String

   static func ==(lhs: User, rhs: User) -> Bool {
      return lhs.id == rhs.id
   }
}
/*:
 Swift 4.1 also introduces synthesized support for the `Hashable` protocol, which means it will generate a `hashValue` property for conforming types automatically. `Hashable` was always annoying to implement because you need to return a unique (or at least mostly unique) hash for every object. It’s important, though, because it lets you use your objects as dictionary keys and store them in sets.

 Previously we’d need to write code like this:
*/
extension User: Hashable {
   var hashValue: Int {
      return firstName.hashValue ^ lastName.hashValue &* 16777619
   }
}
/*:
 For the most part that’s no longer needed in Swift 4.1: just adding the `Hashable` protocol to your type will ask the Swift compiler to generate the `hashValue` property for you. As with `Equatable`, you can still write your own code if there’s something specific you need.

 - note: You still need to opt in to these protocols by adding a conformance to your type, and using the synthesized code does require that all properties in your type conform to `Equatable` or `Hashable` respectively.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
