//
//  SwiftRichString
//  Elegant Strings & Attributed Strings Toolkit for Swift
//
//  Created by Daniele Margutti.
//  Copyright © 2018 Daniele Margutti. All rights reserved.
//
//	Web: http://www.danielemargutti.com
//	Email: hello@danielemargutti.com
//	Twitter: @danielemargutti
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation
import ObjectiveC.runtime

internal func getAssociatedValue<T>(key: String, object: AnyObject) -> T? {
	return (objc_getAssociatedObject(object, key.address) as? AssociatedValue)?.value as? T
}

internal func getAssociatedValue<T>(key: String, object: AnyObject, initialValue: @autoclosure () -> T) -> T {
	return getAssociatedValue(key: key, object: object) ?? setAndReturn(initialValue: initialValue(), key: key, object: object)
}

internal func getAssociatedValue<T>(key: String, object: AnyObject, initialValue: () -> T) -> T {
	return getAssociatedValue(key: key, object: object) ?? setAndReturn(initialValue: initialValue(), key: key, object: object)
}

private func setAndReturn<T>(initialValue: T, key: String, object: AnyObject) -> T {
	set(associatedValue: initialValue, key: key, object: object)
	return initialValue
}

internal func set<T>(associatedValue: T?, key: String, object: AnyObject) {
	set(associatedValue: AssociatedValue(associatedValue), key: key, object: object)
}

internal func set<T: AnyObject>(weakAssociatedValue: T?, key: String, object: AnyObject) {
	set(associatedValue: AssociatedValue(weak: weakAssociatedValue), key: key, object: object)
}

extension String {

	fileprivate var address: UnsafeRawPointer {
		return UnsafeRawPointer(bitPattern: abs(hashValue))!
	}

}

private func set(associatedValue: AssociatedValue, key: String, object: AnyObject) {
	objc_setAssociatedObject(object, key.address, associatedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

private class AssociatedValue {

	weak var _weakValue: AnyObject?
	var _value: Any?

	var value: Any? {
		return _weakValue ?? _value
	}

	init(_ value: Any?) {
		_value = value
	}

	init(weak: AnyObject?) {
		_weakValue = weak
	}

}
