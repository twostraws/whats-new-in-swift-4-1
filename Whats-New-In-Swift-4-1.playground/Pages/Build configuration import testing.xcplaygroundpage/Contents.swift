/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Build configuration import testing

 Swift 4.1 implements [SE-0075](https://github.com/apple/swift-evolution/blob/master/proposals/0075-import-test.md), which introduces a new `canImport` condition that lets us check whether a specific module can be imported when our code is compiled.

 This is particularly important for cross-platform code: if you had a Swift file that implemented one behavior on macOS and another on iOS, or if you needed specific functionality for Linux.

 For example:
*/
#if canImport(SpriteKit)
   // this will be true for iOS, macOS, tvOS, and watchOS
#else
   // this will be true for other platforms, such as Linux
#endif
/*:
 Previously you would have had to use inclusive or exclusive tests by operating system, like this:
 */
#if !os(Linux)
   // Matches macOS, iOS, watchOS, tvOS, and any other future platforms
#endif

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
   // Matches only Apple platforms, but needs to be kept up to date as new platforms are added
#endif
/*:
 The new `canImport` condition lets us focus on the functionality we care about rather than what platform we're compiling for, thus avoiding a variety of problems.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
