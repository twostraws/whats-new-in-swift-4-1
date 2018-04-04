/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Conditional conformances

 Swift 4.1 implements [SE-0143](https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md), which introduced proposed conditional conformances into the language. This allows types to conform to a protocol only when certain conditions are met.

 To demonstrate conditional conformances, let's create a `Purchaseable` protocol that we can use to buy things:
*/
protocol Purchaseable {
   func buy()
}
/*:
 We can now define a `Book` struct that conforms to the protocol, and prints a message when a book is bought:
*/
struct Book: Purchaseable {
   func buy() {
      print("You bought a book")
   }
}
/*:
 So far this is easy enough, but let's take it one step further: what if the user has a basket full of books, and wants to buy them all?

 We could loop over all books in the array by hand, calling `buy()` on each one. But a better approach is to write an extension on `Array` to make it conform to `Purchaseable`, then give it a `buy()` method that in turn calls `buy()` on each of its elements.

 This is where conditional conformances come in: if we tried to extend all arrays, we'd be adding functionality where it wouldn't make sense – we'd be adding `buy()` to arrays of strings, for example, even though those strings don't have a `buy()` method we can call.

 Swift 4.1 lets us make arrays conform to `Purchaseable` only if their elements also conform to `Purchaseable`, like this:
*/
extension Array: Purchaseable where Element: Purchaseable {
   func buy() {
      for item in self {
         item.buy()
      }
   }
}
/*:
 As you can see, conditional conformances let us constrain the way our extensions are applied more precisely than was possible before.

 Conditional conformances also make large parts of Swift code easier and safer, even if you don't do any extra work yourself. For example, this code creates two arrays of optional strings and checks whether they are equal:
*/
var left: [String?] = ["Andrew", "Lizzie", "Sophie"]
var right: [String?] = ["Charlotte", "Paul", "John"]
left == right
/*:
 That might seem trivial, but that code wouldn't even compile in Swift 4.0 – both `String` and `[String]` were equatable, but `[String?]` was not.

 The introduction of conditional conformance in Swift 4.1 means that it’s now possible to add protocol conformance to a type as long as it satisfies a condition.

 In this case, if the elements of the array are equatable, that means the whole thing is equatable. So, the above code now compiles in Swift 4.1

 Conditional conformance has been extended to the `Codable` protocol in a way that will definitely make things safer. For example:
*/
import Foundation

struct Person {
   var name = "Taylor"
}

var people = [Person()]
var encoder = JSONEncoder()
// try encoder.encode(people)
/*:
 If you uncomment the `encoder.encode(people)` line, Swift will refuse to build your code because you're trying to encode a struct that doesn't conform to `Codable`.

 However, that code compiled cleanly with Swift 4.0, then threw a fatal error at runtime because `Person` doesn’t conform to `Codable`.

 Obviously no one wants a fatal error at runtime, because it means your app crashes. Fortunately, Swift 4.1 cleans this up using conditional conformances: `Optional`, `Array`, `Dictionary`, and `Set` now only conform to `Codable` if their contents also conform to `Codable`, so the above code will refuse to compile.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
