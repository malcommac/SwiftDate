//
//	SwiftDate, an handy tool to manage date and timezones in swift
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
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

/// Alternative API from swift.org for avoiding AutoreleasingUnsafeMutablePointer usage in
/// `Foundation.Calendar` and `Foundation.Formatter`
/// - Experiment: This is a draft API currently under consideration for official import into
///   Foundation as a suitable alternative to the AutoreleasingUnsafeMutablePointer usage case of
///   returning a NSDate + NSTimeInterval or using a pair of dates representing a range
/// - Note: Since this API is under consideration it may be either removed or revised in the near
///   future
///
public struct DateInterval {
    public internal(set) var start: Foundation.Date
    public internal(set) var end: Foundation.Date

    public var interval: Foundation.TimeInterval {
        return end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
    }

    public init(start: Foundation.Date, end: Foundation.Date) {
        self.start = start
        self.end = end
    }

    public init(start: Foundation.Date, interval: Foundation.TimeInterval) {
        self.init(start: start, end: Foundation.Date(timeInterval: interval, since: start))
    }
}
