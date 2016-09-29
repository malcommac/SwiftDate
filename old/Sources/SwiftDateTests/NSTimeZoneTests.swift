//
//  NSTimeZoneTests.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 22/02/16.
//  Copyright © 2016 Jeroen Houtzager. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftDate

class NSTimeZoneSpec: QuickSpec {

    override func spec() {

        describe("NSTimeZone") {

            context("fromName") {

                it("should return local time zone") {
                    expect(TimeZoneName.Local.timeZone) == NSTimeZone.localTimeZone()
                }

                it("should return default TimeZone") {
                    expect(TimeZoneName.Default.timeZone) == NSTimeZone.defaultTimeZone()
                }

                it("should return system TimeZone") {
                    expect(TimeZoneName.System.timeZone) == NSTimeZone.systemTimeZone()
                }

                it("should return CET TimeZone") {
                    expect(TimeZoneName.EuropeParis.timeZone) == NSTimeZone(abbreviation: "CET")
                }
            }
        }
    }
}
