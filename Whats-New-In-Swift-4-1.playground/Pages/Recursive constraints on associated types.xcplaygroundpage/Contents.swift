/*:
 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)

 ## Recursive constraints on associated types

 Swift 4.1 implements [SE-0157](https://github.com/apple/swift-evolution/blob/master/proposals/0157-recursive-protocol-constraints.md), which lifts restrictions on the way we use associated types inside protocols. As a result, we can now create recursive constraints for our associated types: associated types that are constrained by the protocol they are defined in.

 To demonstrate this, let's consider a simple team hierarchy in a tech company. In this company, every employee has a manager – someone more senior to them that they report to. Each manager must also be an employee of the company, because it would be weird if they weren't.

 We can express this relationship in a simple `Employee` protocol:
*/
protocol Employee {
   associatedtype Manager: Employee
   var manager: Manager? { get set }
}
/*:
 - note: I've used an optional `Manager?` because ultimately one person (presumably the CEO) has no manager.

 &nbsp;

 Even though that's a fairly self-evident relationship, it wasn't possible to compile that code in Swift 4.0 because we're using the `Employee` protocol inside itself.

 However, this is fixed in Swift 4.1 because of the new ability to use recursive constraints on associated types.

 Thanks to this new feature, we can model a simple tech company that has three kinds of team members: junior developers, senior developers, and board members.

 The reporting structure is also simple: junior developers are managed by senior developers, senior developers are managed by board members, and board members may be managed by another board member – e.g. the CTO reporting to the CEO.

 That looks exactly as you would imagine thanks to Swift 4.1:
 */
class BoardMember: Employee {
   var manager: BoardMember?
}

class SeniorDeveloper: Employee {
   var manager: BoardMember?
}

class JuniorDeveloper: Employee {
   var manager: SeniorDeveloper?
}
/*:
 - note: I've used classes here rather than structs because `BoardMember` itself contains a `BoardMember` property and that would result in an infinitely sized struct. If one of these has to be a class I personally would prefer to make all three classes just for consistency, but if you preferred you could leave `BoardMember` as a class and make both `SeniorDeveloper` and `JuniorDeveloper` into structs.

 &nbsp;

 [< Previous](@previous)           [Home](Introduction)           [Next >](@next)
 */
