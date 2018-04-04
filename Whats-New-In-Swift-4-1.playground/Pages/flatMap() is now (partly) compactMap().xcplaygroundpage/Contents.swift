/*:
 [< Previous](@previous)           [Home](Introduction)

 ## `flatMap()` is now (partly) `compactMap()`

 The `flatMap()` method was useful for a variety of things in Swift 4.0, but one was particularly popular: the ability to transform each object in a collection, then remove any items that were nil afterwards

 Swift Evolution proposal [SE-0187](https://github.com/apple/swift-evolution/blob/master/proposals/0187-introduce-filtermap.md) suggested changing this, and as of Swift 4.1 this `flatMap()` variant has been renamed to `compactMap()` to make its meaning clearer.

 For example:
*/
let array = ["1", "2", "Fish"]
let numbers = array.compactMap { Int($0) }
print(numbers)
/*:
 That will create an `Int` array containing the numbers 1 and 2, because "Fish" will fail conversion to Int, return nil, and be ignored.

 - note: To avoid confusion, it's worth adding that only this specific usage `flatMap()` has been renamed to `compactMap()` – the `flatMap()` method still retains its other behaviors.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)
 */
