/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Key decoding strategy in `Codable`

 The `Codable` protocol, introduced in Swift 4.0, is the fastest and easiest way of converting your data types to JSON and back again. However, often you'd hit a problem where `Codable` wasn't quite as easy as you had hoped: if your JSON used snake_case for its key names and your Swift code used camelCase for its matching property names, `Codable` wouldn’t be able to convert between the two. Instead, you needed to create your own `CodingKeys` mapping to explain how the two matched up.

 Swift 4.1 solves this problem by introducing a new `keyDecodingStrategy` property on `JSONDecoder` that can automatically convert between snake_case and camelCase if you need it. The inverse property, `keyEncodingStrategy`, also exists on `JSONEncoder` so you can convert your Swift camelCase names back into snake_case.

 Let's look at a practical example – this code creates some sample JSON, then converts it into a `Data` instance:
*/
import Foundation

let jsonString = """
 [
    {
       "name": "MacBook Pro",
       "screen_size": 15,
       "cpu_count": 4
    },
    {
       "name": "iMac Pro",
       "screen_size": 27,
       "cpu_count": 18
    }
 ]
 """

 let jsonData = Data(jsonString.utf8)
/*:
 That stores an array of two items, each describing a Mac. As you can see, both `screen_size` and `cpu_count` use snake_case – words are all lowercased, with underscores separating them.

 Now, we want to convert that JSON into an array of `Mac` instances using this struct:
*/
 struct Mac: Codable {
    var name: String
    var screenSize: Int
    var cpuCount: Int
 }
/*:
 That follows standard Swift naming conventions, so the property names are all camelCased – words have no separators, but second and subsequent words all start with a capital letter.

 Using the new `keyDecodingStrategy` of `JSONDecoder` we can convert our sample JSON into a `[Mac]` array like this:
 */
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

do {
   let macs = try decoder.decode([Mac].self, from: jsonData)
   print(macs)
} catch {
   print(error.localizedDescription)
}
/*:
 When you want to go back the other way – to convert a Codable struct with camelCase properties back to JSON with snake_case keys, set the `keyEncodingStrategy` property of your `JSONEncoder` to `.convertToSnakeCase` like this:
*/
if let macs = try? decoder.decode([Mac].self, from: jsonData) {
   // now we have an array to work with, convert it back into JSON
   let encoder = JSONEncoder()
   encoder.keyEncodingStrategy = .convertToSnakeCase
   let encoded = try encoder.encode(macs)
   print(encoded.count)
}
/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
