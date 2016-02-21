import Foundation

/// A Nimble matcher that succeeds when the actual value matches with any of the matchers
/// provided in the variable list of matchers. 
public func satisfyAnyOf<T,U where U: Matcher, U.ValueType == T>(matchers: U...) -> NonNilMatcherFunc<T> {
    return satisfyAnyOf(matchers)
}

internal func satisfyAnyOf<T,U where U: Matcher, U.ValueType == T>(matchers: [U]) -> NonNilMatcherFunc<T> {
    return NonNilMatcherFunc<T> { actualExpression, failureMessage in
        var fullPostfixMessage = "match one of: "
        var matches = false
        for var i = 0; i < matchers.count && !matches; ++i {
            fullPostfixMessage += "{"
            let matcher = matchers[i]
            matches = try matcher.matches(actualExpression, failureMessage: failureMessage)
            fullPostfixMessage += "\(failureMessage.postfixMessage)}"
            if i < (matchers.count - 1) {
                fullPostfixMessage += ", or "
            }
        }
        
        failureMessage.postfixMessage = fullPostfixMessage
        if let actualValue = try actualExpression.evaluate() {
            failureMessage.actualValue = "\(actualValue)"
        }
        
        return matches
    }
}

public func ||<T>(left: NonNilMatcherFunc<T>, right: NonNilMatcherFunc<T>) -> NonNilMatcherFunc<T> {
    return satisfyAnyOf(left, right)
}

public func ||<T>(left: FullMatcherFunc<T>, right: FullMatcherFunc<T>) -> NonNilMatcherFunc<T> {
    return satisfyAnyOf(left, right)
}

public func ||<T>(left: MatcherFunc<T>, right: MatcherFunc<T>) -> NonNilMatcherFunc<T> {
    return satisfyAnyOf(left, right)
}

extension NMBObjCMatcher {
    public class func satisfyAnyOfMatcher(matchers: [NMBObjCMatcher]) -> NMBObjCMatcher {
        return NMBObjCMatcher(canMatchNil: false) { actualExpression, failureMessage in
            if matchers.isEmpty {
                failureMessage.stringValue = "satisfyAnyOf must be called with at least one matcher"
                return false
            }
            
            var elementEvaluators = [NonNilMatcherFunc<NSObject>]()
            for matcher in matchers {
                let elementEvaluator: (Expression<NSObject>, FailureMessage) -> Bool = {
                    expression, failureMessage in
                    return matcher.matches(
                        {try! expression.evaluate()}, failureMessage: failureMessage, location: actualExpression.location)
                }
                
                elementEvaluators.append(NonNilMatcherFunc(elementEvaluator))
            }
            
            return try! satisfyAnyOf(elementEvaluators).matches(actualExpression, failureMessage: failureMessage)
        }
    }
}
