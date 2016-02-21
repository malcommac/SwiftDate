import Foundation

/// Make an expectation on a given actual value. The value given is lazily evaluated.
public func expect<T>(@autoclosure(escaping) expression: () throws -> T?, file: String = __FILE__, line: UInt = __LINE__) -> Expectation<T> {
    return Expectation(
        expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true))
}

/// Make an expectation on a given actual value. The closure is lazily invoked.
public func expect<T>(file: String = __FILE__, line: UInt = __LINE__, expression: () throws -> T?) -> Expectation<T> {
    return Expectation(
        expression: Expression(
            expression: expression,
            location: SourceLocation(file: file, line: line),
            isClosure: true))
}

/// Always fails the test with a message and a specified location.
public func fail(message: String, location: SourceLocation) {
    let handler = NimbleEnvironment.activeInstance.assertionHandler
    handler.assert(false, message: FailureMessage(stringValue: message), location: location)
}

/// Always fails the test with a message.
public func fail(message: String, file: String = __FILE__, line: UInt = __LINE__) {
    fail(message, location: SourceLocation(file: file, line: line))
}

/// Always fails the test.
public func fail(file: String = __FILE__, line: UInt = __LINE__) {
    fail("fail() always fails", file: file, line: line)
}

/// Like Swift's precondition(), but raises NSExceptions instead of sigaborts
internal func nimblePrecondition(
    @autoclosure expr: () -> Bool,
    @autoclosure _ name: () -> String,
    @autoclosure _ message: () -> String) -> Bool {
        let result = expr()
        if !result {
            let e = NSException(
                name: name(),
                reason: message(),
                userInfo: nil)
            e.raise()
        }
        return result
}

@noreturn
internal func internalError(msg: String, file: String = __FILE__, line: UInt = __LINE__) {
    fatalError(
        "Nimble Bug Found: \(msg) at \(file):\(line).\n" +
        "Please file a bug to Nimble: https://github.com/Quick/Nimble/issues with the " +
        "code snippet that caused this error."
    )
}